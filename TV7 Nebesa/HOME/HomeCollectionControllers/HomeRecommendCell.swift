//
//  HomeRecommendCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/11/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class HomeRecommendCell: BaseCell, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recommendTableView: UITableView!
    
    let cellIdentifier = "tableCell"
    
        var homeScreenData: HomeScreenProgrammes = HomeScreenProgrammes() {
            didSet {
                DispatchQueue.main.async {
                    self.recommendTableView.reloadData()
                }
            }
        }
   
    override func setupViews() {
        
        setupTableView()
    }
    
    func setupTableView() {
        homeScreenDownloadService(homeScreenData: HomeScreenData())
        print(HomeScreenData())
        recommendTableView.dataSource = self
        recommendTableView.delegate = self
        recommendTableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
       
        recommendTableView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
        recommendTableView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func homeScreenDownloadService(homeScreenData: HomeScreenData) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenDataURL
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
                self.homeScreenData = try JSONDecoder().decode(HomeScreenProgrammes.self, from: responseData)
               
            } catch let error {
                print(error.localizedDescription)
            }
        }
        urlSessionTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenData.homeScreenProgrammes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as? RecommendTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = homeScreenData.homeScreenProgrammes[indexPath.row]
         print(homeScreenData.homeScreenProgrammes)
        return cell
    
}
}
