//
//  APIService.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 5/28/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

class ApiService: NSObject {
    
    static let shared = ApiService()
    let baseUrl = NetworkEndpoints.baseURL
    
    enum dataModel {
        case homeScreenProgrammeInformation
        case homeScreenNewestProgrammes
    }
    
    func requestVideoInfo(completion: @escaping (HomeScreenProgrammeInformation) -> ()) {
     performRequest(requestType: .fetchVideoData, completion: completion)
    }
    
    func requestNewestVideos(completion: @escaping (HomeScreenNewestProgrammes) -> ()) {
        performRequestForNewest(requestType: .fetchHomeScreenNewestProgrammes, completion: completion)
    }
    

    public enum NetworkRequestType {
       
        case fetchHomeScreenProgrammeData
        case fetchHomeScreenNewestProgrammes
        case fetchHomeScreenMostViewedProgrammes
        case fetchVideoData
      
    }
    
     var requestURL: [NetworkRequestType : String] = [
       
        //Most Viewed/ Newest programmes URL's on the homeScreen
        .fetchHomeScreenNewestProgrammes : NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenNewestProgrammesURL,
        .fetchHomeScreenMostViewedProgrammes : NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenMostViewedProgrammesURL,
        .fetchVideoData: NetworkEndpoints.baseURL + NetworkEndpoints.programmeInfoURL,
     
    ]
    
    enum networkResult: Swift.Error {
        case noValidUrl
        case wrongPath
        case noData
        case errorOccured
        case unknownError
    }
    
    
    func performRequest(requestType: NetworkRequestType, completion: @escaping (HomeScreenProgrammeInformation) -> Void)  {
        guard let urlString = requestURL[requestType] else {return}
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        print(url)
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Loading err",error.localizedDescription)
            }
            do {
            guard let data = data else {return}
                let videos = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: data)
                print(data)
                DispatchQueue.main.async {
                    completion(videos)
                }
            
            } catch let jsonError {
                print(jsonError)
            }
            
        
        }
        urlSessionTask.resume()
    }
    
    func performRequestForNewest(requestType: NetworkRequestType, completion: @escaping (HomeScreenNewestProgrammes) -> Void)  {
        guard let urlString = requestURL[requestType] else {return}
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        print(url)
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Loading err",error.localizedDescription)
            }
            do {
                guard let data = data else {return}
                let videos = try JSONDecoder().decode(HomeScreenNewestProgrammes.self, from: data)
                print(data)
                DispatchQueue.main.async {
                    completion(videos)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
        }
        urlSessionTask.resume()
    }

    
}

//    func requestRecommendVideos(completion: @escaping (HomeScreenData) -> ()) {
//        performRequest(requestType: .fetchHomeScreenMainData, completion: completion)
//    }

//    NetworkService.performRequest(requestType: NetworkService.NetworkRequestType.fetchVideoData) { result in
//    switch result {
//    case .failure(let error):
//    print(error.localizedDescription)
//    case .success(let data):
//    self.serializeVideoInfo(requestData: data, dataModel: HomeScreenProgrammeInformation.self as! Codable)
//    print("Video data",data)
//    }
//    }

//
//    func serializeVideoInfo(requestData: (Data), dataModel: Codable) {
//        do {
//            let videos = try JSONDecoder().decode(HomeScreenProgrammeInformation.self, from: requestData)
//            print("Video Data", requestData)
//            print("-------->!!!", videos)
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func serializeNewestVideos(requestData: (Data), dataModel: Codable) {
//        do {
//            let videos = try JSONDecoder().decode(HomeScreenNewestProgrammes.self, from: requestData)
//            print("Video Data", requestData)
//            print("-------->!!!", videos)
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }

//    func fetchVideos(completion: @escaping ([Video]) -> ()) {
//        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
//    }
//
//    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
//        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
//    }
//
//    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
//        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
//    }


