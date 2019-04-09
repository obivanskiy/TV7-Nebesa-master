//
//  NetworkServiceByIvan.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/27/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

class NetworkService {
    
    public enum NetworkRequestType {
        case fetchParentCategories
        case fetchSubCategories
        case fetchCategoryData
        case fetchSeriesMainData
        case fetchSeriesProgrammes
        case fetchWebTVProgrammesList
        //
        case fetchHomeScreenMainData
        case fetchHomeScreenProgrammeData
        //
        case fetchHomeScreenNewestProgrammes
        case fetchHomeScreenMostViewedProgrammes
    }
    
    static var requestURL: [NetworkRequestType : String] = [
        
        .fetchParentCategories : NetworkEndpoints.baseURL + NetworkEndpoints.parentCategoriesURL,
       
        //Home Screen data 
        .fetchHomeScreenMainData : NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenDataURL,
       
        //Most Viewed/ Newest programmes URL's on the homeScreen
        .fetchHomeScreenNewestProgrammes : NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenNewestProgrammesURL,
        .fetchHomeScreenMostViewedProgrammes : NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenMostViewedProgrammesURL
        
//        .fetchWebTVProgrammesList: NetworkEndpoints.baseURL + NetworkEndpoints.webTVGuideURL
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


