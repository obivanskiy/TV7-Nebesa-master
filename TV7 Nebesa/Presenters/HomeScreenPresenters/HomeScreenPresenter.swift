//
//  HomeScreenPresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/8/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class HomeRecommendPresenter {
    let collectionCell: HomeRecommendCell!
    
    init(with collectionCell: HomeRecommendCell) {
        self.collectionCell = collectionCell
        requestHomeScreenMainInformation()
 
    }
    
    
    
    private func requestHomeScreenMainInformation() {
        
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMainData) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenMainInformation(requestData: data)
                print("00101010100101presenter",data)
            }
        }
    }
    
    private func serializeHomeScreenMainInformation(requestData: (Data)) {
        do {
            collectionCell.self.homeScreenData  = try JSONDecoder().decode(HomeScreenProgrammes.self, from: requestData)
            print("---------", requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
    

