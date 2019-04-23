//
//  HomeRecommendCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/11/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class HomeRecommendCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    var myViewController : HomeBaseViewController!
    @IBOutlet weak var recommendTableView: UITableView!
    
    private var homeScreenProgrammeDataSegue: String = "HomeScreenProgrammePageSegue"
    
    
        var homeScreenData: HomeScreenProgrammes = HomeScreenProgrammes() {
            didSet {
                DispatchQueue.main.async {
                    self.recommendTableView.reloadData()
                }
            }
        }
   
    override func awakeFromNib() {
        requestHomeScreenMainInformation()
        setupTableView()
    }
    
    func setupTableView() {
//        homeScreenDownloadService(homeScreenData: HomeScreenData())
        recommendTableView.dataSource = self
        recommendTableView.delegate = self
       
//       print(homeScreenData.homeScreenProgrammes)
//        recommendTableView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
//        recommendTableView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                let cell = tableView.cellForRow(at: indexPath) as! RecommendTableViewCell
                HomeVideoPlayerController.programInfo = cell.cellModel ?? HomeScreenData()
            }
    
            private func requestHomeScreenMainInformation() {
                NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMainData) { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let data):
                        self.serializeHomeScreenMainInformation(requestData: data)
                        print("data1",data)
                   
                    }
                }
                
            }
        
            private func serializeHomeScreenMainInformation(requestData: (Data)) {
                do {
                    self.homeScreenData  = try JSONDecoder().decode(HomeScreenProgrammes.self, from: requestData)
                    print("Aaaa", homeScreenData.homeScreenProgrammes)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(">>>>", homeScreenData.homeScreenProgrammes.count)
        return homeScreenData.homeScreenProgrammes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as? RecommendTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = homeScreenData.homeScreenProgrammes[indexPath.row]
         print(indexPath.row)
        return cell
    
}
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            myViewController.navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//           myViewController.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
}






//    func homeScreenDownloadService(homeScreenData: HomeScreenData) {
//        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenDataURL
//        guard let url = URL(string: urlToParse) else {
//            return
//        }
//        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
//            guard error == nil else {
//                return
//            }
//            guard let responseData = data else {
//                return
//            }
//            do {
//                self.homeScreenData = try JSONDecoder().decode(HomeScreenProgrammes.self, from: responseData)
//
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        urlSessionTask.resume()
//    }
