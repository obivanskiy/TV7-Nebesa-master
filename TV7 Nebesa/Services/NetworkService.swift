//
//  NetworkServiceByIvan.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/27/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation



class NetworkService {
    public enum NetworkRequestType: Hashable {
        case fetchParentCategories
        case fetchSubCategories
        case fetchCategoryData
    }
    
    static var requestURL: [NetworkRequestType : String] = [
        .fetchParentCategories : NetworkEndpoints.baseURL + NetworkEndpoints.parentCategoriesURL,
    ]

    enum networkResult: Swift.Error {
        case noValidUrl
        case wrongPath
        case noData
        case errorOccured
        case unknownError
    }
    
    static func performRequest(requestType: NetworkRequestType, completion: @escaping (Result<Data, Error>) -> Void)  {
        
        guard let urlString = requestURL[requestType] else {
            completion(.failure(networkResult.wrongPath))
            return
        }
        print(urlString)
        guard let url = URL(string: urlString) else {
            completion(.failure(networkResult.noValidUrl))
            return
        }
        print(url)
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }  else if let data = data {
                completion(.success(data))
                print(data)
            } else {
                completion(.failure(networkResult.unknownError))
            }
        }
        urlSessionTask.resume()
    }
}

