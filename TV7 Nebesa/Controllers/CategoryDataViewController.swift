//
//  CategoryDataViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import SVProgressHUD

final class CategoryDataTableViewController: UITableViewController {

    // MARK: - Properties
    private let seriesDataSegue = "SeriesDataSegue"
    private var categoryDataPresenter: CategoryDataPresenter?
    var categoryData: CategoryProgrammes = CategoryProgrammes() {
        didSet {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        self.categoryDataPresenter = CategoryDataPresenter(with: self)
        SVProgressHUD.show()
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryData.categoryProgrammes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDataTableViewCell.identifier, for: indexPath) as? CategoryDataTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = categoryData.categoryProgrammes[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }

        if segue.identifier == seriesDataSegue {
            guard segue.destination is CategorySeriesTableViewController else {
                return
            }
            NetworkService.requestURL[.fetchSeriesMainData] = NetworkEndpoints.baseURL + NetworkEndpoints.seriesInfoURL + categoryData.categoryProgrammes[indexPath.row].id
            NetworkService.requestURL[.fetchSeriesProgrammes] = NetworkEndpoints.baseURL + NetworkEndpoints.seriesProgrammesURL + categoryData.categoryProgrammes[indexPath.row].id
        }
    }
}

