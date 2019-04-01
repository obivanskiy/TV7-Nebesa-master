//
//  CategorySeriesPresenter.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/31/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class CategorySeriesPresenter {
    let viewController: CategorySeriesTableViewController!
    
    init(with viewController: CategorySeriesTableViewController) {
        self.viewController = viewController
        requestSeriesMainInformation()
    }
    
    private func requestSeriesMainInformation() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSeriesMainData) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeSeriesMainInformation(requestData: data)
            }
        }
    }
    
    private func serializeSeriesMainInformation(requestData: (Data)) {
        do {
            viewController.self.seriesData  = try JSONDecoder().decode(ProgrammeInformation.self, from: requestData)
            print(viewController.self.seriesData)
            self.requestSeriesProgrammes()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func requestSeriesProgrammes() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSeriesProgrammes) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeSeriesProgrammes(requestData: data)
            }
        }
    }
    
    private func serializeSeriesProgrammes(requestData: (Data)) {
        do {
            viewController.self.seriesProgrammes  = try JSONDecoder().decode(SeriesProgrammes.self, from: requestData)
            print(NetworkService.requestURL[.fetchSeriesProgrammes])
            print("**********************")
            print(viewController.self.seriesProgrammes)
        } catch let error {
            print(error.localizedDescription)
        }
    }




}
