//
//  CategoryDataViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation
import UIKit

class CategoryDataTableViewController: UITableViewController {
    
    
    private(set) var categoryData: CategoryProgrammes = CategoryProgrammes() {
        didSet {
            let _ = categoryData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        archiveCategoriesDownloadService()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 122
    }
    
    func archiveCategoriesDownloadService() {
        let urlToParse = "https://sandbox.tv7.fi/nebesa/api/jed/get_tv7_category_programs/?category_id=6"
        guard let url = URL(string: urlToParse) else { return }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard error == nil else { return }
            guard let responseData = data else { return }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryDataCell", for: indexPath) as? CategoryDataTableViewCell else {return UITableViewCell()}
        cell.categoryVideoNameOutlet.text = categoryData.categoryProgrammes[indexPath.row].name
        cell.previewImagePath = categoryData.categoryProgrammes[indexPath.row].imagePath
        cell.fetchImage()
        
        return cell
    }
}

