////
////  BroadcastVC.swift
////  TV7 Nebesa
////
////  Created by Богдан Воробйовський on 3/12/19.
////  Copyright © 2019 Богдан Воробйовський. All rights reserved.
////
//import UIKit
//
//class BroadcastViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
//
//    //MARK: - Outlets
//    @IBOutlet weak var tvGuideTableView: UITableView!
//    @IBOutlet weak var dateCollectioView: UICollectionView!
//
//
//    //MARK: - Private properties
//    private (set) var tvGuideSeries: [String]? = [] {
//        didSet {
//            guard let _ = tvGuideSeries else { return }
//            DispatchQueue.main.async {
//                self.tvGuideTableView.reloadData()
//            }
//        }
//    }
//
//    private (set) var tvGuideDate: [String]? = [] {
//        didSet {
//            guard let _ = tvGuideDate else { return }
//            DispatchQueue.main.async {
//                self.tvGuideTableView.reloadData()
//            }
//        }
//    }
//
//    let dates = [10.02, 11.01, 18.10, 13.02, 14.05, 12.01, 13.01, 14.02, 15.06]
//
//
//    //MARK: - Lifecycle methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        setupTVGuideTableView()
//        setupDateCollectionView()
//        generateDates()
//        firstAppearSelectedItem()
//    }
//
//    //MARK: - Table View Data Source Methods
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let numberOfRowsInSection = tvGuideSeries?.count else { return 1 }
//
//        return numberOfRowsInSection
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvGuideCell", for: indexPath) as? TVGuideCell else { return UITableViewCell()}
//        cell.seriesTVGuide.text = tvGuideSeries?[indexPath.row]
//        cell.timeTVGuide.text = tvGuideDate?[indexPath.row]
//        return cell
//    }
//
//
//    //MARK: - Table View Delegate Methods
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tvGuideTableView.cellForRow(at: indexPath) as? TVGuideCell else { return }
//
//        if cell.captionLabel.text == "" {
//            cell.isExpanded = true
//        }
//
//        switch cell.isExpanded {
//        case true:
//            self.expandedRows.remove(indexPath.row)
//        case false:
//            self.expandedRows.insert(indexPath.row)
//        }
//
//        // ******** Expanded cells haven't work yet *********
//        switch cell.captionLabel.calculateMaxLines() {
//        case 1:
//            print("1")
//        case 2:
//            print("2")
//        case 3:
//            print("3")
//        default:
//            print("default")
//        }
//
//        cell.isExpanded = !cell.isExpanded
//
//        self.tvGuideTableView.beginUpdates()
//        self.tvGuideTableView.endUpdates()
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        guard let cell = tvGuideTableView.cellForRow(at: indexPath) as? TVGuideCell else { return }
//
//        self.expandedRows.remove(indexPath.row)
//        cell.isExpanded = false
//        self.tvGuideTableView.beginUpdates()
//        self.tvGuideTableView.endUpdates()
//    }
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if scrollView == tvGuideTableView {
//            self.lastContentOffset = scrollView.contentOffset.y
//        }
//    }
//
//    // Hide DateCollection when scrolling down
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == tvGuideTableView {
//            if (self.lastContentOffset < scrollView.contentOffset.y) {
//                dateStackView.isHidden = true
//                tvGuideTableViewConstraint.constant = 0
//            } else if (self.lastContentOffset > scrollView.contentOffset.y) {
//                dateStackView.isHidden = false
//                tvGuideTableViewConstraint.constant = 36
//            }
//        }
//    }
//
//    //MARK: - Collection View Data Source Methods
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let numberOfItemsInSection = dates.count
//        return numberOfItemsInSection
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCollectionViewCell
//        let dates = self.dates[indexPath.row]
//        cell.dateLabel.text = String(dates)
//        return cell
//    }
//
//    //MARK: - Collection View Delegate Methods
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedCell: UICollectionViewCell = dateCollectioView.cellForItem(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor(red: 124/256, green: 77/256, blue: 255/256, alpha: 0.7)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        guard let cellToDeselect: UICollectionViewCell = dateCollectioView.cellForItem(at: indexPath) else { return }
//        cellToDeselect.contentView.backgroundColor = UIColor.clear
//    }
//
//    //MARK: Actions
//
//    // MARK: - Private Methods
//    private func dateFormatter(_ dateIn: String) -> String {
//        guard let unixDate = Double(dateIn) else { return "" }
//        let date = Date(timeIntervalSince1970: unixDate)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//
//        let newDate = dateFormatter.string(from: date)
//        return newDate
//    }
//
//    func setupTVGuideTableView() {
//        tvGuideTableView.dataSource = self
//        //Register for TVGuideCell.xib
//        tvGuideTableView.register(UINib(nibName: "TVGuideCell", bundle: .none), forCellReuseIdentifier: "tvGuideCell")
//        tvGuideTableView.allowsSelection = false
//
//    }
//
//    func setupDateCollectionView() {
//        dateCollectioView.dataSource = self
//        dateCollectioView.delegate = self
//        dateCollectioView.allowsSelection = true
//        dateCollectioView.reloadData()
//    }
//
//    // Select and display the current day in DateCollection
//    private func firstAppearSelectedItem() {
//        let firstAppearSelectedItem = arrayOfDatesStrings.count/2
//        let selectedIndexPath = IndexPath(item: firstAppearSelectedItem, section: 0)
//        dateCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
//    }
//
//    //Need to think about this. Isn't working now
//    private func scrollToCurrentTime() {
//        let selectedIndexPath = IndexPath(item: 12, section: 0)
//        self.tvGuideTableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
//    }
//
//    // Display Alert Message
//    private func displayMessage(_ userMessage: String) -> Void {
//        let alertController = UIAlertController(title: "Oops", message: userMessage, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//
//    //MARK: - TV Guide Series Download
//    private func downloadServiceForChosenDate(_ date: String) {
//        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.tvGuide + date
//        guard let url = URL(string: urlToParse) else { return }
//        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard error == nil else { return }
//            guard let responseData = data else { return }
//            do {
//                self.tvGuideSeries = try JSONDecoder().decode(TVGuideDates.self, from: responseData)
//            } catch let error {
//                print("Error is \(error)")
//            }
//        }
//        urlSessionTask.resume()
//    }
//}
//
//
