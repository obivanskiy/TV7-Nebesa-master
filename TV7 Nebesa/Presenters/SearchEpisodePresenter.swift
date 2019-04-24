//
//  SearchEpisodePresenter.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/23/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

class SearchEpisodePresenter {
    let viewController: SearchEpisodeViewController!
    var episodeId = String()

    init(with viewController: SearchEpisodeViewController, episodeId: String) {
        self.viewController = viewController
        self.episodeId = episodeId
        fetchSearchEpisode(episodeId)
        request()
    }

    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSearchEpisode) { (result) in
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
            viewController.self.searchEpisodeData = try JSONDecoder().decode(SearchEpisode.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func fetchSearchEpisode(_ episodeId: String) {
        NetworkService.requestURL[.fetchSearchEpisode] = NetworkEndpoints.baseURL + NetworkEndpoints.searchEpisodeURL + episodeId
    }
}
