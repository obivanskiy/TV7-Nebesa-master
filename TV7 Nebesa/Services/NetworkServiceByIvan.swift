//
//  NetworkServiceByIvan.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/27/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


enum RequestFor {
    case fetchParentCategories
}

private var requestURL: [RequestFor: String] = [
    .fetchParentCategories: NetworkEndpoints.baseURL + NetworkEndpoints.parentCategoriesURL
]

class NetworkServiceByIvan {
    
    enum networkResult: Swift.Error {
        case noValidUrl
        case wrongPath
        case noData
        case errorOccured
    }
    static func performRequest(request: RequestFor, completion: @escaping (Result<Data, Error>) -> Void)  {
        guard let urlString = requestURL[.fetchParentCategories] else {
            completion(.failure(networkResult.wrongPath))
            return
        }
        guard let url = URL(string: urlString) else {
            completion(.failure(networkResult.noValidUrl))
            return
        }
        print(url)
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
                print(data)
            }
        }
        urlSessionTask.resume()
        
    }
}

