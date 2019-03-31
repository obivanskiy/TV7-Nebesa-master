//
//  CategoryDataPresenter.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/28/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

final class CategoryDataPresenter {
    
//    MARK: -Stored properties
    let viewController: CategoryDataTableViewController!
    static var parentCategoryID: String?
    var parenCategoryData: SubCategories = SubCategories()
    var categoryID: String  =  ""
    static var categoryTitle: String?
    
    init(with viewController: CategoryDataTableViewController){
        self.viewController = viewController
        if CategoryDataPresenter.parentCategoryID != "" {
            self.requestForParentCategory()
            self.requestForGettingParentData()
        } else {
            requestForGettingParentData()
        }
    }
    //MARK: - Private functions
    private func requestForParentCategory() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchSubCategories) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeParentCategoryData(requestData: data)
                for obj in self.parenCategoryData.subCategories {
                    NetworkService.requestURL[.fetchCategoryData] = NetworkEndpoints.baseURL + NetworkEndpoints.categoryDataURL + obj.categoryID
                    print(obj.categoryID)
                }
                self.requestForGettingParentData()
            }
        }
    }
    
    private func serializeParentCategoryData(requestData: (Data)) {
        do {
            self.parenCategoryData  = try JSONDecoder().decode(SubCategories.self, from: requestData)
            print(parenCategoryData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func requestForGettingParentData() {
        NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchCategoryData) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeCategoryData(requestData: data)
            }
        }
    }
    
    private func serializeCategoryData(requestData: (Data)) {
        do {
            viewController.self.categoryData  = try JSONDecoder().decode(CategoryProgrammes.self, from: requestData)
            viewController.self.title = CategoryDataPresenter.categoryTitle ?? ""
            print(viewController.self.categoryData)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

