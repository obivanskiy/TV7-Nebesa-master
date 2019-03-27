//
//  ArchiveVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class ParentCategoriesTableViewController: UITableViewController {
    
    private var presenter: ParentCategoriesPresenter?
    private let quickNavigationSections = ["2", "5", "4", "9", "10"]
    private let subCategoriesSegue = "SubCategoriesSegue"
    private let programmeSegue = "ProgrammeSegue"
    var parentCategories: ParentCategories = ParentCategories() {
        didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
    
    
    //MARK: - View Controller Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ParentCategoriesPresenter(with: self)
    }
        
    //MAR(K: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let numOfRows = presenter?.parentCategories.parentCategories.count else { return 0 }
        
        return parentCategories.parentCategories.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (quickNavigationSections.contains(parentCategories.parentCategories[indexPath.row].id)) {
            self.performSegue(withIdentifier: subCategoriesSegue, sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            self.performSegue(withIdentifier: programmeSegue, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ParentCategoryNameTableViewCell.identifier, for: indexPath) as? ParentCategoryNameTableViewCell else {
            return UITableViewCell()
        }
        cell.categoryNameLabel.text = parentCategories.parentCategories[indexPath.row].name
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            assertionFailure("Identifier not found!")
            return
        }
        switch identifier {
        case subCategoriesSegue:
            guard let subCategoriesViewController = segue.destination as? SubCategoriesTableViewController else {
                return
            }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            subCategoriesViewController.subCategories = parentCategories.parentCategories[indexPath.row]
        case programmeSegue:
            guard let categoryDataController = segue.destination as? CategoryDataTableViewController else {
                return
            }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            categoryDataController.parentCategoryData = parentCategories.parentCategories[indexPath.row]
        default:
            assertionFailure("Identifier was not recognized")
        }
    }
}
