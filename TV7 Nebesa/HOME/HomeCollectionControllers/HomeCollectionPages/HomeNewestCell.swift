//
//  NewestHomeCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit


class HomeNewestCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var newestTableView: UITableView!
    
   var homeScreenNewestData: HomeScreenNewestProgrammes = HomeScreenNewestProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.newestTableView.reloadData()
                
            }
        }
    }
    
    override func awakeFromNib() {
        requestHomeScreenNewestInformation()
        setupTableView()
    }
    
    func setupTableView() {
        //        homeScreenDownloadService(homeScreenData: HomeScreenData())
        newestTableView.dataSource = self
        newestTableView.delegate = self
        
        print(homeScreenNewestData.homeScreenNewestProgrammes)
        newestTableView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
        newestTableView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenNewestData.homeScreenNewestProgrammes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = newestTableView.dequeueReusableCell(withIdentifier: "newestCellId", for: indexPath) as? NewestTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = homeScreenNewestData.homeScreenNewestProgrammes[indexPath.row]
        print(homeScreenNewestData.homeScreenNewestProgrammes)
       
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = tableView.cellForRow(at: indexPath) as! NewestTableViewCell
//        HomeVideoPlayerController.programInfo = cell.cellModel ?? HomeScreenData()
    }
    
    private func requestHomeScreenNewestInformation() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenNewestProgrammes) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenNewestInformation(requestData: data)
            }
        }
    }
    
    private func serializeHomeScreenNewestInformation(requestData: (Data)) {
        do {
            self.homeScreenNewestData  = try JSONDecoder().decode(HomeScreenNewestProgrammes.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}