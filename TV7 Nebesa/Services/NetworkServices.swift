//
//  File.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

enum Request {
    case getParentCategories
}

private var urlDict: [Request: String] = [
    .getParentCategories: NetworkEndpoints.baseURL + NetworkEndpoints.parentCategoriesURL
]

class NetworkService {
    
    enum rRequestError: Swift.Error {
        case noExpectedAssociatedValue
        case notValidURL
    }
    
    static func execute(request: Request, completion: @escaping (Result<Data,Error>) -> Void) {
        guard let urlString = urlDict[request] else {
            completion(.failure(rRequestError.noExpectedAssociatedValue))
            return
        }
        guard let url = URL(string: urlString) else {
            completion(.failure(rRequestError.notValidURL))
            return
        }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        urlSessionTask.resume()
    }
}

