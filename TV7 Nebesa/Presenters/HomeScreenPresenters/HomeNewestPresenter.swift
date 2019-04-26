//
//  HomeNewestPresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/25/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class HomeNewestPresenter {
    let collectionCell: HomeNewestCell!
    
    init(with collectionCell: HomeNewestCell) {
        self.collectionCell = collectionCell
        requestHomeScreenNewestProgrammes()
     
    }
    
    // Second cell-Screen
    private func requestHomeScreenNewestProgrammes() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenNewestProgrammes) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenNewestProgrammes(requestData: data)
            }
        }
    }
    
    private func serializeHomeScreenNewestProgrammes(requestData: (Data)) {
        do {
            collectionCell.self.homeScreenNewestData  = try JSONDecoder().decode(HomeScreenNewestProgrammes.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
