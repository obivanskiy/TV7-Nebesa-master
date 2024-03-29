//
//  SearchResultsPresenter.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/15/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


class SearchResultsPresenter {
    let viewController: SearchViewController!
    var userText = String()

    init(with viewController: SearchViewController, userText: String) {
        self.viewController = viewController
        self.userText = userText
        fetchSearchResults(userText)
        request()
    }

    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSearchResults) { (result) in
            self.viewController.removeActivityIndicator()
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
            viewController.self.searchResults = try JSONDecoder().decode(SearchResults.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func fetchSearchResults(_ userText: String) {
        viewController.showActivityIndicator(onView: viewController.view)
        guard let userText = userText.encodeUrl() else { return }
        NetworkService.requestURL[.fetchSearchResults] = NetworkEndpoints.searchBaseURL + NetworkEndpoints.searchResultsURL + userText
    }
}
