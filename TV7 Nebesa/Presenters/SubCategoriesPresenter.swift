//
//  SubCategoriesPresenter.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/28/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


final class SubCategoriesPresenter {
    
    //MARK: - Stored properties
    let viewController: SubCategoriesTableViewController!
    
    //MARK: - Initializers
    init(with viewController: SubCategoriesTableViewController){
        self.viewController = viewController
        request()
    }
    
    //MARK: - Private functions
    private func request() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSubCategories) { (result) in
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
            viewController.self.subCategoriesData  = try JSONDecoder().decode(SubCategories.self, from: requestData)
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
