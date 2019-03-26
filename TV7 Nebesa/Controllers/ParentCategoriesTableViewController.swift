//
//  ArchiveVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class ParentCategoriesTableViewController: UITableViewController {
    
    private(set) var categoriesData: ParentCategories = ParentCategories() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - View Controller Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Finish error handling
    enum RequestError: Error {
        case serverError(error: Error)
        case dataIsEmpty
        case decodingError
        case wrongUrlString
    }
    
    // MARK: - Categories Names Download Service
        
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesData.parentCategories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (["2", "5", "4", "9", "10"].contains(categoriesData.parentCategories[indexPath.row].id)) {
            self.performSegue(withIdentifier: "SubCategoriesSegue", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            self.performSegue(withIdentifier: "ProgrammeSegue", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ParentCategoryNameTableViewCell.identifier, for: indexPath) as? ParentCategoryNameTableViewCell else {
            return UITableViewCell()
        }
        cell.categoryNameLabel.text = categoriesData.parentCategories[indexPath.row].name
        
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            assertionFailure("Identifier not found!")
            return
        }
        switch identifier {
        case "SubCategoriesSegue":
            guard let subCategoriesViewController = segue.destination as? SubCategoriesTableViewController else {
                return
            }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            subCategoriesViewController.subCategories = categoriesData.parentCategories[indexPath.row]
        case "ProgrammeSegue":
            guard let categoryDataController = segue.destination as? CategoryDataTableViewController else {
                return
            }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            categoryDataController.parentCategoryData = categoriesData.parentCategories[indexPath.row]
        default:
            assertionFailure("Identifier was not recognized")
        }
    }
}
