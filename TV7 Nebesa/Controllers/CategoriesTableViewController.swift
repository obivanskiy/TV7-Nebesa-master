//
//  ArchiveVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class CategoriesTableViewController: UITableViewController {
    
    
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
        tableView.estimatedRowHeight = 50
        archiveCategoriesDownloadService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Архив"
    }
    
    // MARK: - Finish error handling
    enum RequestError: Error {
        case serverError(error: Error)
        case dataIsEmpty
        case decodingError
        case wrongUrlString
    }
    
    // MARK: - Categories Names Download Service
    func archiveCategoriesDownloadService() {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.categoryNameURL
        guard let url = URL(string: urlToParse) else { return }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard error == nil else { return }
            guard let responseData = data else { return }
            do {
                self.categoriesData = try JSONDecoder().decode(ParentCategories.self, from: responseData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        urlSessionTask.resume()
    }
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesData.parentCategories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CategoryDataSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryNameTableViewCell.identifier, for: indexPath) as? CategoryNameTableViewCell else {
            return UITableViewCell()
        }
        cell.categoryNameLabel.text = categoriesData.parentCategories[indexPath.row].name
      
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
            viewController.category = categoriesData.parentCategories[indexPath.row]
        }
    }
}
