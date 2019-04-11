//
//  HomeScreenNewestVideosPresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/9/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
//
//import Foundation
//
//final class HomeScreenNewestVideosPresenter {
//    let viewController: NebessaScreenController!
//    
//    init(with viewController: NebessaScreenController) {
//        self.viewController = viewController
//        requestHomeScreenMainInformation()
//    }
//    
//    
//    
//    private func requestHomeScreenMainInformation() {
//        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenMainData) { result in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let data):
//                self.serializeHomeScreenMainInformation(requestData: data)
//            }
//        }
//    }
//    
//    private func serializeHomeScreenMainInformation(requestData: (Data)) {
//        do {
//            viewController.self.homeScreenData  = try JSONDecoder().decode(HomeScreenProgrammes.self, from: requestData)
//            self.requestHomeScreenNewestProgrammeInfo()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
//    private func requestHomeScreenNewestProgrammeInfo() {
//        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchHomeScreenProgrammeData) { result in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let data):
//                self.serializeHomeScreenNewestProgrammeInfo(requestData: data)
//            }
//        }
//    }
//    
//    private func serializeHomeScreenNewestProgrammeInfo(requestData: (Data)) {
//        do {
//            viewController.self.homeScreenProgrammeInfo  = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: requestData)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
    //Newest Programmes
    
    // Most Viewed Programmes
    
    
//}
