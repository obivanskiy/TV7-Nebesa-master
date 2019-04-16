//
//  NewestHomeCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


class HomeNewestCell: HomeRecommendCell {
   var homeScreenNewestProgrammes: HomeScreenNewestProgrammes = HomeScreenNewestProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.recommendTableView.reloadData()
            }
        }
    }
    private func requestHomeScreenMainInformation() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenNewestProgrammes) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenMainInformation(requestData: data)
            }
        }
    }
    
    private func serializeHomeScreenMainInformation(requestData: (Data)) {
        do {
            self.homeScreenNewestProgrammes  = try JSONDecoder().decode(HomeScreenNewestProgrammes.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
