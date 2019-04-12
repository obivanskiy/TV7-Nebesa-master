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
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var tvGuideTableViewConstraintToTop: NSLayoutConstraint!

    //MARK: - TVProgram properties
    var tvGuideSeries: TVGuideDates = TVGuideDates() {
        didSet {
            DispatchQueue.main.async {
                self.tvGuideTableView.reloadData()
            }
        }
    }
    private var presenter: TVProgramPresenter?
    private var arrayOfDates = [Date]()
    private var arrayOfDatesStrings = [String]()
    private var expandedRows = Set<Int>()
    private var lastContentOffset: CGFloat = 0

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TVProgramPresenter(with: self)
        setupTVGuideTableView()
        setupDateCollectionView()
        generateDates()
        firstAppearSelectedItem()
    }

    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvGuideSeries.tvGuideDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVGuideCell.identifier, for: indexPath) as? TVGuideCell else {
            return UITableViewCell()
        }
        let data = tvGuideSeries.tvGuideDates

        if !data.isEmpty {
            switch data[indexPath.row] {
            case let (x) where x.series == "":
                cell.seriesLabel.text = data[indexPath.row].name
            case let (x) where x.name != "":
                cell.seriesLabel.text = "\(data[indexPath.row].series): " + "\(data[indexPath.row].name)"
            default:
                cell.seriesLabel.text = data[indexPath.row].series
            }
            cell.timeLabel.text = dateFormatter(data[indexPath.row].date)
            cell.captionLabel.text = data[indexPath.row].caption
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

        // ******** Expanded cells haven't work yet *********
        switch cell.captionLabel.calculateMaxLines() {
        case 1:
            print("1")
        case 2:
            print("2")
        case 3:
            print("3")
        default:
            print("default")
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

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == tvGuideTableView {
            self.lastContentOffset = scrollView.contentOffset.y
        }
    }

    // Hide DateCollection when scrolling down
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tvGuideTableView {
            if (self.lastContentOffset < scrollView.contentOffset.y) {
                dateStackView.isHidden = true
                tvGuideTableViewConstraintToTop.constant = 0
            } else if (self.lastContentOffset > scrollView.contentOffset.y) {
                dateStackView.isHidden = false
                tvGuideTableViewConstraintToTop.constant = 36
            }
        }
    }

    //MARK: - Collection View Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfDatesStrings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCollectionViewCell
        let dates = self.arrayOfDatesStrings[indexPath.row]
        cell.dateLabel.text = dates
        return cell
    }

    //MARK: - Collection View Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter = TVProgramPresenter(with: self, chosenDate: arrayOfDates[indexPath.row])
        tvGuideTableView.reloadData()
    }

    // MARK: - Private Methods
    // Formates Unix date into the normal format
    fileprivate func dateFormatter(_ dateIn: String) -> String {
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
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        dateCollectionView.allowsSelection = true
        dateCollectionView.reloadData()
    }

    // Generate Dates from the current date +/- 15 days for requests to server
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

    // Select and display the current day in DateCollection
    private func firstAppearSelectedItem() {
        let firstAppearSelectedItem = arrayOfDatesStrings.count/2
        let selectedIndexPath = IndexPath(item: firstAppearSelectedItem, section: 0)
        dateCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }

    //Need to think about this. Isn't working now
    private func scrollToCurrentTime() {
        let selectedIndexPath = IndexPath(item: 12, section: 0)
        self.tvGuideTableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
    }

    // Display Alert Message
    private func displayMessage(_ userMessage: String) -> Void {
        let alertController = UIAlertController(title: "Oops", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }


}

