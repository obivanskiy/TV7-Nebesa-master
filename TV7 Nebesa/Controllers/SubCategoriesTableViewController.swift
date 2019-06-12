//
//  SubCategoriesTableViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import SVProgressHUD

final class SubCategoriesTableViewController: UITableViewController {
    
    private var categoryDataSegue: String = "CategoryDataSegue"
    private  var subCategoriesPresenter: SubCategoriesPresenter?
    static var subCategoryTitle: String?
    
    var subCategoriesData: SubCategories = SubCategories() {
        didSet {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
        }
    }

    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subCategoriesPresenter = SubCategoriesPresenter(with: self)
        SVProgressHUD.show()
        self.title = SubCategoriesTableViewController.subCategoryTitle
    }
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoriesData.subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: categoryDataSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoryTableViewCell.identifier, for: indexPath) as? SubCategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.subCategoryNameLabel.text = subCategoriesData.subCategories[indexPath.row].categoryName
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == categoryDataSegue {
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            NetworkService.requestURL[.fetchCategoryData] = NetworkEndpoints.baseURL + NetworkEndpoints.categoryDataURL + subCategoriesData.subCategories[indexPath.row].categoryID
            CategoryDataPresenter.parentCategoryID = ""
            CategoryDataPresenter.categoryTitle = subCategoriesData.subCategories[indexPath.row].categoryName
        }
    }
}

