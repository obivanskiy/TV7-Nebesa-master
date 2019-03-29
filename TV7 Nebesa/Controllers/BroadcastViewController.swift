//
//  BroadcastVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
import UIKit

class BroadcastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

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
    private var expandedRows = Set<Int>()


    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadServiceForChosenDate(currentDate(Date()))
        setupTVGuideTableView()
        setupDateCollectionView()
        generateDates()
        firstAppearSelectedItem()
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

        let data = tvGuideSeries.tvGuideDates

        if !data.isEmpty {
            if tvGuideSeries.tvGuideDates[indexPath.row].series == "" {
                cell.seriesTVGuide.text = tvGuideSeries.tvGuideDates[indexPath.row].name
            } else if tvGuideSeries.tvGuideDates[indexPath.row].name != "" {
                cell.seriesTVGuide.text = "\(tvGuideSeries.tvGuideDates[indexPath.row].series): " + "\(tvGuideSeries.tvGuideDates[indexPath.row].name)"
            } else {
                cell.seriesTVGuide.text = tvGuideSeries.tvGuideDates[indexPath.row].series
            }
            cell.timeTVGuide.text = dateFormatter(tvGuideSeries.tvGuideDates[indexPath.row].date)
            cell.captionLabel.text = tvGuideSeries.tvGuideDates[indexPath.row].caption
        } else {
            displayMessage("Sorry, we have no data on this date")
        }
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }


    //MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tvGuideTableView.cellForRow(at: indexPath) as? TVGuideCell else { return }

        if cell.captionLabel.text == "" {
            cell.isExpanded = true
        }

        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        cell.isExpanded = !cell.isExpanded

        self.tvGuideTableView.beginUpdates()
        self.tvGuideTableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tvGuideTableView.cellForRow(at: indexPath) as? TVGuideCell else { return }

        self.expandedRows.remove(indexPath.row)
        cell.isExpanded = false
        self.tvGuideTableView.beginUpdates()
        self.tvGuideTableView.endUpdates()
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
        
        if tvGuideSeries.tvGuideDates.isEmpty {
            displayMessage("Sorry, we have no data on this date")
        }
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

    private func setupTVGuideTableView() {
        tvGuideTableView.dataSource = self
        tvGuideTableView.delegate = self

        //Register for TVGuideCell.xib
        tvGuideTableView.register(UINib(nibName: "TVGuideCell", bundle: .none), forCellReuseIdentifier: TVGuideCell.identifier)
        tvGuideTableView.allowsSelection = true
        tvGuideTableView.rowHeight = UITableView.automaticDimension
    }

   private func setupDateCollectionView() {
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
        for number in -15...15 {
            guard let newDate = NSCalendar.current.date(byAdding: .day, value: number, to: Date()) else { continue }
            arrayOfDates.append(newDate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM"
            let formattedDate = dateFormatter.string(from: newDate)
            arrayOfDatesStrings.append(formattedDate)
        }
    }

    private func firstAppearSelectedItem() {
        let firstAppearSelectedItem = arrayOfDatesStrings.count/2
        let selectedIndexPath = IndexPath(item: firstAppearSelectedItem, section: 0)
        dateCollectioView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }

    //Need to think about this. Isn't working now
    private func scrollToCurrentTime() {
//        let numberOfRows = tvGuideTableView.numberOfRows(inSection: 0)
//        print(numberOfRows)
        let selectedIndexPath = IndexPath(item: 12, section: 0)
        self.tvGuideTableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
    }

    private func displayMessage(_ userMessage: String) -> Void {
        let alertController = UIAlertController(title: "Error", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }



}
