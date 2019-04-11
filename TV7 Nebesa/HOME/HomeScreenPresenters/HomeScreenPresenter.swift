//
//  HomeScreenPresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/8/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class HomeScreenPresenter {
    let viewController: NebessaScreenController!
    
    init(with viewController: NebessaScreenController) {
        self.viewController = viewController
        requestHomeScreenMainInformation()
    }
    
    
    
    private func requestHomeScreenMainInformation() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMainData) { result in
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
            viewController.self.homeScreenData  = try JSONDecoder().decode(HomeScreenProgrammes.self, from: requestData)
            self.requestHomeScreenProgrammeInfo()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func requestHomeScreenProgrammeInfo() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenProgrammeData) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeHomeScreenProgrammeInfo(requestData: data)
            }
        }
    }
    
    private func serializeHomeScreenProgrammeInfo(requestData: (Data)) {
        do {
            viewController.self.homeScreenProgrammeInfo  = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Newest Programmes

    // Most Viewed Programmes
    
    
}
