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
    
    private var presenterForMostViewed: HomeMostViewedPresenter?
    
    var homeMostViewedData: HomeScreenMostViewedProgrammes = HomeScreenMostViewedProgrammes(){
        didSet {
            DispatchQueue.main.async {
                self.mostViewedTableView.reloadData()
            }
        }
    }
//

    override func awakeFromNib() {
        print(">>>", "awakeFromNib")
        self.presenterForMostViewed = HomeMostViewedPresenter(with: self)
        setupTableView()
    }
    
    func setupTableView() {
        //        homeScreenDownloadService(homeScreenData: HomeScreenData())
        mostViewedTableView.dataSource = self
        mostViewedTableView.delegate = self
        
        print(homeMostViewedData.homeScreenMostViewedProgrammes)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return homeMostViewedData.homeScreenMostViewedProgrammes.count
        
//        return homeMostViewedData.homeScreenMostViewedProgrammes.count
//        homeMostViewedData.homeScreenMostViewedProgrammes.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MostViewedCell", for: indexPath) as? MostViewedTableViewCell
            else {
                print("BAD NEWS")
            return UITableViewCell()
        }
//        cell.cellModel = homeMostViewedData.homeScreenMostViewedProgrammes[indexPath.row]
//        print(homeMostViewedData.homeScreenMostViewedProgrammes)
        cell.cellModel = homeMostViewedData.homeScreenMostViewedProgrammes[indexPath.row]
        print(homeMostViewedData.homeScreenMostViewedProgrammes)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = tableView.cellForRow(at: indexPath) as! MostViewedTableViewCell
        //        HomeVideoPlayerController.programInfo = cell.cellModel ?? HomeScreenData()
    }
    
//    func requestHomeScreenMostViewedInformation() {
//        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMostViewedProgrammes) { result in
//
//            print(">>>", result)
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let data):
//                self.serializeHomeScreenMostViewedInformation(requestData: data)
//                print("data1", data)
//                for obj in self.homeMostViewedData.homeScreenMostViewedProgrammes {
//                    NetworkService.requestURL[.fetchVideoData] = NetworkEndpoints.baseURL + NetworkEndpoints.programmeInfoURL + obj.id
//                    self.requestVideoInfo()
//                }
//
//            }
//        }
//    }
//
//    func serializeHomeScreenMostViewedInformation(requestData: (Data)) {
//        do {
//            self.homeMostViewedData  = try JSONDecoder().decode(HomeScreenMostViewedProgrammes.self, from: requestData)
//            print(homeMostViewedData.homeScreenMostViewedProgrammes)
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//
//    private func requestVideoInfo() {
//        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchVideoData) { result in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let data):
//                self.serializeVideoInfo(requestData: data)
//                print("Video data",data)
//
//            }
//        }
//
//    }
//
//    private func serializeVideoInfo(requestData: (Data)) {
//        do {
//            self.videoData  = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: requestData)
//            print("Video Data", requestData )
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
}

