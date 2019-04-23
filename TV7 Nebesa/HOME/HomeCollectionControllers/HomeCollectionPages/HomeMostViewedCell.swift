//
//  HomeMostViewedCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class HomeMostViewedCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mostViewedTableView: UITableView!
    
    var homeMostViewedData: HomeScreenMostViewedProgrammes = HomeScreenMostViewedProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.mostViewedTableView.reloadData()
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        print(">>>", "awakeFromNib")
        requestHomeScreenMostViewedInformation()
        setupTableView()
    }
    
    func setupTableView() {
        //        homeScreenDownloadService(homeScreenData: HomeScreenData())
        mostViewedTableView.dataSource = self
        mostViewedTableView.delegate = self
        
        print(homeMostViewedData.homeScreenMostViewedProgrammes)
//        mostViewedTableView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
//        mostViewedTableView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(">>>", homeMostViewedData.homeScreenMostViewedProgrammes.count)
        return homeMostViewedData.homeScreenMostViewedProgrammes.count
//        homeMostViewedData.homeScreenMostViewedProgrammes.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MostViewedCell", for: indexPath) as? MostViewedTableViewCell
            else {
                print("BAD NEWS")
            return UITableViewCell()
        }
        cell.cellModel = homeMostViewedData.homeScreenMostViewedProgrammes[indexPath.row]
        print(homeMostViewedData.homeScreenMostViewedProgrammes)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = tableView.cellForRow(at: indexPath) as! MostViewedTableViewCell
        //        HomeVideoPlayerController.programInfo = cell.cellModel ?? HomeScreenData()
    }
    
    func requestHomeScreenMostViewedInformation() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMostViewedProgrammes) { result in
            
            print(">>>", result)
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenMostViewedInformation(requestData: data)
                print("data1", data)
             
               
            }
        }
    }
    
    func serializeHomeScreenMostViewedInformation(requestData: (Data)) {
        do {
            self.homeMostViewedData  = try JSONDecoder().decode(HomeScreenMostViewedProgrammes.self, from: requestData)
            print("BBBB", homeMostViewedData.homeScreenMostViewedProgrammes.count)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

