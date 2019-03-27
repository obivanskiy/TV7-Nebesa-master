//
//  ParentCategoriesPresenter.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class ParentCategoriesPresenter {
    var parentCategories: ParentCategories = ParentCategories()
    let viewController: ParentCategoriesTableViewController!
    
    
    init(with viewController: ParentCategoriesTableViewController) {
        self.viewController = viewController
        request()
    }
    
    func printres() {
        print(self.parentCategories)
    }
    
    private func request() {
        NetworkServiceByIvan.performRequest(request: RequestFor.fetchParentCategories) { result in
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
