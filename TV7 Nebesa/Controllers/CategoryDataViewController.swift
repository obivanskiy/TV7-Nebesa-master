//
//  CategoryDataViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class CategoryDataTableViewController: UITableViewController {
    
    private var seriesDataSegue: String = "SeriesDataSegue"
    private var categoryDataPresenter: CategoryDataPresenter?
    var categoryData: CategoryProgrammes = CategoryProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        self.categoryDataPresenter = CategoryDataPresenter(with: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 122
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("num \(categoryData.categoryProgrammes.count)")
        return categoryData.categoryProgrammes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDataTableViewCell.identifier, for: indexPath) as? CategoryDataTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = categoryData.categoryProgrammes[indexPath.row]
        print(indexPath.row)
        
        return cell
    }
    
    //MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == seriesDataSegue {
//            guard let viewController = segue.destination as? CategorySeriesTableViewController else {
//                return
//            }
//            guard let indexPath = self.tableView.indexPathForSelectedRow else {
//                return
//            }
//        }
//    }
}

