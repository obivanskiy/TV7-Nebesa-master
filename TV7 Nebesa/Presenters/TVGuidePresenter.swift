//
//  WebTVScreenPresenter.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/3/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


class TVGuidePresenter {
    
    let viewController: WebTVScreenViewController!
    
    init(with viewController: WebTVScreenViewController){
        self.viewController = viewController
        fetchCurrentDate()
        request()
    }
    
    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchWebTVProgrammesList) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeData(requestData: data)
            }
        }
    }
    
    private func serializeData(requestData: (Data)) {
        do {
            viewController.self.webTVProgrammesList  = try JSONDecoder().decode(TVGuideDates.self, from: requestData)
            print(viewController.self.webTVProgrammesList)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchCurrentDate() {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        NetworkService.requestURL[.fetchWebTVProgrammesList] = NetworkEndpoints.baseURL + NetworkEndpoints.webTVGuideURL + dateString
    }
}
