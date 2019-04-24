//
//  HomeProgrammePresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/8/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
//
//import Foundation
//
//final class CategorySeriesPresenter {
//    let viewController: HomeVideoPlayerController!
//    
//    init(with viewController: HomeVideoPlayerController) {
//        self.viewController = viewController
//        requestHomeScreenProgrammes()
//    }
//
//private func requestHomeScreenProgrammes() {
//    NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSeriesProgrammes) { result in
//        switch result {
//        case .failure(let error):
//            print(error.localizedDescription)
//        case .success(let data):
//            self.serializeHomeScreenProgrammes(requestData: data)
//        }
//    }
//}
//
//private func serializeHomeScreenProgrammes(requestData: (Data)) {
//    do {
//        viewController.self.HomeScreenProgrammeInformation  = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: requestData)
//    } catch let error {
//        print(error.localizedDescription)
//    }
//    }
//}
