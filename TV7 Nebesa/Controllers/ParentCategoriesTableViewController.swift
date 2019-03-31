//
//  ArchiveVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class ParentCategoriesTableViewController: UITableViewController {
    //MARK: - Private properties
    private var parentCategoriespresenter: ParentCategoriesPresenter?
    private let quickNavigationSections = ["5", "4", "9", "10"]
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
        self.parentCategoriespresenter = ParentCategoriesPresenter(with: self)
    }
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            NetworkService.requestURL[.fetchSubCategories] = NetworkEndpoints.baseURL + NetworkEndpoints.subCategoriesURL + parentCategories.parentCategories[indexPath.row].id
            SubCategoriesTableViewController.subCategoryTitle = parentCategories.parentCategories[indexPath.row].name
        case programmeSegue:
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            NetworkService.requestURL[.fetchSubCategories] = NetworkEndpoints.baseURL + NetworkEndpoints.subCategoriesURL + parentCategories.parentCategories[indexPath.row].id
            CategoryDataPresenter.parentCategoryID = parentCategories.parentCategories[indexPath.row].id
            CategoryDataPresenter.categoryTitle = parentCategories.parentCategories[indexPath.row].name
        default:
            assertionFailure("Identifier was not recognized")
        }
    }
}
