//
//  ParsingService.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


class ArchiveCategoriesDownloadService {
    
    static var categoriesNames: [ParentCategories] = []
    
    // MARK: - Finish error handling
//    enum RequestError: Error {
//        case serverError(error: Error)
//        case dataIsEmpty
//        case decodingError
//        case wrongUrlString
//    }
    // MARK: - Parser function, that takes in url for parsing
//    static func archiveCategoriesDownloadService() {
//        let urlToParse = "https://sandbox.tv7.fi/nebesa/api/jed/get_tv7_parent_categories/"
//        guard let url = URL(string: urlToParse) else { return }
//        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
//            guard error == nil else { return }
//            guard let responseData = data else { return }
//            do {
//                let entity = try JSONDecoder().decode(ParentCategories.self, from: responseData)
//                
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        urlSessionTask.resume()
//    }
}
