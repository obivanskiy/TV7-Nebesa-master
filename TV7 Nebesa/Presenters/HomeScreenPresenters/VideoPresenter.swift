//
//  VideoPresenter.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/25/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
//NetworkService.requestURL[.fetchVideoData] = NetworkEndpoints.baseURL + NetworkEndpoints.programmeInfoURL + homeScreenData.homeScreenProgrammes[indexPath.row].id

import Foundation

final class VideoPresenter {
    let viewController: VideoPlayer!
    
    
    init(with viewController: VideoPlayer) {
        self.viewController = viewController
        requestVideoInfo()
    }
    
    private func requestVideoInfo() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchVideoData) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeVideoInfo(requestData: data)
                print("Video data",data)
            }
        }
    }

    private func serializeVideoInfo(requestData: (Data)) {
        do {
            viewController.self.videoData  = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: requestData)
            print("Video Data", requestData )

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}


