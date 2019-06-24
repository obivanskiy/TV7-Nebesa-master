//
//  ArchiveVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import SVProgressHUD

final class ParentCategoriesTableViewController: UITableViewController, InternetConnection {
    
    //MARK: - Private properties
    private var parentCategoriespresenter: ParentCategoriesPresenter?
    private let quickNavigationSections = ["5", "4", "9", "10"]
    private enum Constants {
        static let programmeSegue = "ProgrammeSegue"
        static let searchVC = "SearchViewController"
        static let subCategoriesSegue = "SubCategoriesSegue"
        static let programmeScreen = "ProgrammeScreen"
    }
    
    var parentCategories: ParentCategories = ParentCategories() {
        didSet {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - View Controller Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parentCategoriespresenter = ParentCategoriesPresenter(with: self)
        SVProgressHUD.show()
        checkInternetConnection()
        title = "Архив"
        setupNavBarButtons()
    }

    //MARK: - Table View Data Source and Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentCategories.parentCategories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkInternetConnection()
        if (quickNavigationSections.contains(parentCategories.parentCategories[indexPath.row].id)) {
            self.performSegue(withIdentifier: Constants.subCategoriesSegue, sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            self.performSegue(withIdentifier: Constants.programmeSegue, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ParentCategoryNameTableViewCell.identifier, for: indexPath) as? ParentCategoryNameTableViewCell else {
            return UITableViewCell()
        }
        cell.categoryNameLabel.text = parentCategories.parentCategories[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            assertionFailure("Identifier not found!")
            return
        }
        switch identifier {
        case Constants.subCategoriesSegue:
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            NetworkService.requestURL[.fetchSubCategories] = NetworkEndpoints.baseURL + NetworkEndpoints.subCategoriesURL + parentCategories.parentCategories[indexPath.row].id
            SubCategoriesTableViewController.subCategoryTitle = parentCategories.parentCategories[indexPath.row].name
        case Constants.programmeSegue:
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

    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchPressed))
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
    }

    @objc private func searchPressed() {
        guard let searchVC = UIStoryboard(name: Constants.programmeScreen, bundle: nil).instantiateViewController(withIdentifier: Constants.searchVC) as? SearchViewController else {
            return
        }
        self.navigationController?.pushViewController(searchVC, animated: true)
    }

}
