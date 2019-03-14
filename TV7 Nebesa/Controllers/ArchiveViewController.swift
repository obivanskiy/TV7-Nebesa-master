//
//  ArchiveVC.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Oulets
    @IBOutlet weak var archiveTableView: UITableView!
    
    private(set) var categoriesData: ParentCategories = ParentCategories() {
        didSet {
            let _ = categoriesData
            DispatchQueue.main.async {
                self.archiveTableView.reloadData()
            }
        }
    }
    //MARK: - View Controller Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        archiveTableView.delegate = self
        archiveTableView.dataSource = self
        archiveCategoriesDownloadService()
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
        let urlToParse = "https://sandbox.tv7.fi/nebesa/api/jed/get_tv7_parent_categories/"
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfCells = categoriesData.parentCategories.count
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        archiveTableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "CategoryDataSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArchiveTableViewCell", for: indexPath) as? ArchiveViewControllerTableViewCell else { return UITableViewCell()}
        cell.categoryNameLabel.text = categoriesData.parentCategories[indexPath.row].name
      
        return cell
    }
}
