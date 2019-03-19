//
//  SubCategoriesTableViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class SubCategoriesTableViewController: UITableViewController {
    
    var subCategoriesData: SubCategories = SubCategories() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var subCategories: CategoriesDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let subCategory = subCategories else {
            return
        }
        subCategoriesDownloadService(subCategory: subCategory)
    }

    func subCategoriesDownloadService(subCategory: CategoriesDetails) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.subCategoriesURL + subCategory.id
        guard let url = URL(string: urlToParse) else { return }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard error == nil else { return }
            guard let responseData = data else { return }
            do {
                self.subCategoriesData = try JSONDecoder().decode(SubCategories.self, from: responseData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        urlSessionTask.resume()
    }
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoriesData.subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CategoryDataSegue", sender: self)
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
        if segue.identifier == "CategoryDataSegue" {
            guard let viewController = segue.destination as? CategoryDataTableViewController else {
                return
            }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            viewController.category = subCategoriesData.subCategories[indexPath.row]
        }
    }
}

