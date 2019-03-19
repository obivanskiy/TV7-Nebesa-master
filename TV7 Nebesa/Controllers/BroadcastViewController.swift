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
    private (set) var tvGuideSeries: [String]? = [] {
        didSet {
            guard let _ = tvGuideSeries else { return }
            DispatchQueue.main.async {
                self.tvGuideTableView.reloadData()
            }
        }
    }

    private (set) var tvGuideDate: [String]? = [] {
        didSet {
            guard let _ = tvGuideDate else { return }
            DispatchQueue.main.async {
                self.tvGuideTableView.reloadData()
            }
        }
    }

    let dates = [10.02, 11.01, 18.10, 13.02, 14.05, 12.01, 13.01, 14.02, 15.06]


    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTVGuideTableView()
        setupDateCollectionView()
        tvGuideDownloadService()
    }


    //MARK: - TV Guide Series Download
    func tvGuideDownloadService() {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.tvGuide
        guard let url = URL(string: urlToParse) else { return }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            do {
                let entity = try JSONDecoder().decode(TVGuideDates.self, from: responseData)
                for key in entity.tvGuideDates {
                    if key.name != "" {
                        self.tvGuideSeries?.append(key.series + ": " + key.name)
                    } else {
                        self.tvGuideSeries?.append(key.series)
                    }
                    let date = self.dateFormatter(key.date)
                    self.tvGuideDate?.append(date)
                }
            } catch let error {
                print("Error is \(error)")
            }
        }
        urlSessionTask.resume()
    }

    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRowsInSection = tvGuideSeries?.count else { return 1 }

        return numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvGuideCell", for: indexPath) as? TVGuideCell else { return UITableViewCell()}
        cell.seriesTVGuide.text = tvGuideSeries?[indexPath.row]
        cell.timeTVGuide.text = tvGuideDate?[indexPath.row]
        return cell
    }

    //MARK: - Collection View Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItemsInSection = dates.count
        return numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCollectionViewCell
        let dates = self.dates[indexPath.row]
        cell.dateLabel.text = String(dates)
        return cell
    }

    //MARK: - Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell: UICollectionViewCell = dateCollectioView.cellForItem(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 124/256, green: 77/256, blue: 255/256, alpha: 0.7)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cellToDeselect: UICollectionViewCell = dateCollectioView.cellForItem(at: indexPath) else { return }
        cellToDeselect.contentView.backgroundColor = UIColor.clear
    }

    //MARK: Actions

    // MARK: - Private Methods
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
        tvGuideTableView.register(UINib(nibName: "TVGuideCell", bundle: .none), forCellReuseIdentifier: "tvGuideCell")
        tvGuideTableView.allowsSelection = false

    }

    func setupDateCollectionView() {
        dateCollectioView.dataSource = self
        dateCollectioView.delegate = self
        dateCollectioView.allowsSelection = true
        dateCollectioView.reloadData()
    }

}
