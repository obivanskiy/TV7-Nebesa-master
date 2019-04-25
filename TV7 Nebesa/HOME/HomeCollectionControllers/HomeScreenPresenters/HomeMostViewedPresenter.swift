//
//  HomeMostViewedPresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/25/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class HomeMostViewedPresenter {
    let collectionCell: HomeMostViewedCell!
    
    init(with collectionCell: HomeMostViewedCell) {
        self.collectionCell = collectionCell
        requestHomeScreenMostViewedProgrammes()
    }
    
    //Third mostViewedCellScreen
    
    
    private func requestHomeScreenMostViewedProgrammes() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMostViewedProgrammes) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenMostViewedProgrammes(requestData: data)
            }
        }
    }
    
    private func serializeHomeScreenMostViewedProgrammes(requestData: (Data)) {
        do {
            collectionCell.self.homeMostViewedData  = try JSONDecoder().decode(HomeScreenMostViewedProgrammes.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
