//
//  CategoryDataViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class CategoryDataTableViewController: UITableViewController {
    
    private(set) var categoryData: CategoryProgrammes = CategoryProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var parentCategoryData: CategoriesDetails? 
    var subCategoryData: SubCategoriesDetails?
    
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 122
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let category = subCategoryData else {
            return
        }
        archiveCategoriesDownloadService(category: category)
        self.title = category.categoryName
    }
    
    func archiveCategoriesDownloadService(category: SubCategoriesDetails) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.categoryDataURL + category.categoryID
        guard let url = URL(string: urlToParse) else {
            return
        }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard error == nil else {
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                self.categoryData = try JSONDecoder().decode(CategoryProgrammes.self, from: responseData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        urlSessionTask.resume()
    }
    
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeriesDataSegue" {
            guard let viewController = segue.destination as? CategorySeriesTableViewController else {
                return
            }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            viewController.categoryData = categoryData.categoryProgrammes[indexPath.row]
        }
    }
}

