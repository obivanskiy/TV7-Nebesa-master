//
//  BroadcastVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
import UIKit

class BroadcastViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: - Outlets
    @IBOutlet weak var tvGuideTableView: UITableView!
    @IBOutlet weak var dateCollectioView: UICollectionView!


    //MARK: - Private properties
    private (set) var tvGuideSeries: TVGuideDates = TVGuideDates() {
        didSet {
            DispatchQueue.main.async {
                self.tvGuideTableView.reloadData()
            }
        }
    }
    private var arrayOfDates = [Date]()
    private var arrayOfDatesStrings = [String]()


    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvGuideTableView.rowHeight = UITableView.automaticDimension
        self.tvGuideTableView.estimatedRowHeight = 70
        downloadServiceForChosenDate(currentDate(Date()))
        setupTVGuideTableView()
        setupDateCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        generateDates()
    }


    //MARK: - TV Guide Series Download
    func downloadServiceForChosenDate(_ date: String) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.tvGuide + date
        guard let url = URL(string: urlToParse) else { return }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            do {
                self.tvGuideSeries = try JSONDecoder().decode(TVGuideDates.self, from: responseData)
            } catch let error {
                print("Error is \(error)")
            }
        }
        urlSessionTask.resume()
    }

    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvGuideSeries.tvGuideDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVGuideCell.identifier, for: indexPath) as? TVGuideCell else { return UITableViewCell()}
        cell.seriesTVGuide.text = tvGuideSeries.tvGuideDates[indexPath.row].series
        cell.timeTVGuide.text = dateFormatter(tvGuideSeries.tvGuideDates[indexPath.row].date)
        return cell
    }

    //MARK: - Collection View Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItemsInSection = arrayOfDatesStrings.count
        return numberOfItemsInSection
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCollectionViewCell
        let dates = self.arrayOfDatesStrings[indexPath.row]
        cell.dateLabel.text = dates
        return cell
    }

    //MARK: - Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        downloadServiceForChosenDate(currentDate(arrayOfDates[indexPath.row]))
        tvGuideTableView.reloadData()
    }

    //MARK: - Private Methods
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let newDate = dateFormatter.string(from: date)
        return newDate
    }

    func setupTVGuideTableView() {
        tvGuideTableView.dataSource = self
        //Register for TVGuideCell.xib
        tvGuideTableView.register(UINib(nibName: "TVGuideCell", bundle: .none), forCellReuseIdentifier: TVGuideCell.identifier)
        tvGuideTableView.allowsSelection = false
    }

    func setupDateCollectionView() {
        dateCollectioView.dataSource = self
        dateCollectioView.delegate = self
        dateCollectioView.allowsSelection = true
        dateCollectioView.reloadData()
    }

    private func currentDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateFormat = dateFormatter.string(from: date)
        return currentDateFormat
    }

    private func generateDates() {
        for number in -10...10 {
            guard let newDate = NSCalendar.current.date(byAdding: .day, value: number, to: Date()) else { continue }
            arrayOfDates.append(newDate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM"
            let formattedDate = dateFormatter.string(from: newDate)
            arrayOfDatesStrings.append(formattedDate)
        }
    }

}
