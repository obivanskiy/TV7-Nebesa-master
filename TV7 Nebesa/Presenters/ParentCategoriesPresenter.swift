//
//  ParentCategoriesPresenter.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class ParentCategoriesPresenter {

    let viewController: ParentCategoriesTableViewController!
    
    init(with viewController: ParentCategoriesTableViewController) {
        self.viewController = viewController
        request()
        
    }
    
    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchParentCategories) { result in
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
            viewController.self.parentCategories  = try JSONDecoder().decode(ParentCategories.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
