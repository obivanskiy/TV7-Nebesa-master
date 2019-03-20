//
//  CategorySeriesTableViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class CategorySeriesTableViewController: UITableViewController {
    
    var seriesData: ProgrammeInformation = ProgrammeInformation() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var categoryData: CategoryProgrammesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        fetchSeriesData(categoryData: categoryData ?? CategoryProgrammesData())
    }
    
    func fetchSeriesData(categoryData: CategoryProgrammesData) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.seriesInfoURL + categoryData.id
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
                self.seriesData = try JSONDecoder().decode(ProgrammeInformation.self, from: responseData)
                print(self.seriesData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        urlSessionTask.resume()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
        return seriesData.programmeInfo.count
        } else {
        return 0
        }
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesInfoTableViewCell.identifier, for: indexPath) as? SeriesInfoTableViewCell else { return UITableViewCell() }
                cell.cellModel = seriesData.programmeInfo[indexPath.row]
                return cell
}
//        else if indexPath.section == 1 {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoTableViewCell.identifier, for: indexPath) as? EpisodeInfoTableViewCell else { return UITableViewCell() }
//                cell.cellModel = seriesData.programmeInfo[indexPath.row]
//            }
}
