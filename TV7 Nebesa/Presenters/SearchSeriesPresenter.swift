//
//  SearchSeriesPresenter.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/25/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

class SearchSeriesPresenter {
    let viewController: SearchSeriesViewController!
    var episodeId = String()

    init(with viewController: SearchSeriesViewController, episodeId: String) {
        self.viewController = viewController
        self.episodeId = episodeId
        fetchSearchEpisode(episodeId)
        request()
    }

    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSearchSeries) { (result) in
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
            viewController.self.searchSeriesData = try JSONDecoder().decode(SeriesProgrammes.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func fetchSearchEpisode(_ episodeId: String) {
        NetworkService.requestURL[.fetchSearchSeries] = NetworkEndpoints.baseURL + NetworkEndpoints.seriesProgrammesURL + episodeId
    }
}
