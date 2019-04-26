//
//  TVProgrammePresenter.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


class TVProgramPresenter {
    let viewController: BroadcastViewController!
    var chosenDate = Date()

    init(with viewController: BroadcastViewController, chosenDate: Date = Date()) {
        self.viewController = viewController
        self.chosenDate = chosenDate
        fetchChosenDate(chosenDate)
        request()
    }

    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchTVProgram) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeData(requestData: data)
            }
        }
    }

    private func serializeData(requestData: Data) {
        do {
            viewController.self.tvGuideSeries = try JSONDecoder().decode(TVGuideDates.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func fetchChosenDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let chosenDateString = dateFormatter.string(from: date)
        NetworkService.requestURL[.fetchTVProgram] = NetworkEndpoints.baseURL + NetworkEndpoints.tvGuide + chosenDateString
    }
}

