//
//  HomeScreenMostViewedProgrammes.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/9/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct HomeScreenMostViewedProgrammes: Codable {
   
    let homeScreenMostViewedProgrammes: [HomeMostViewedData]
    
    enum CodingKeys: String, CodingKey {
        case homeScreenMostViewedProgrammes = "get_tv7_vod_previousweek_stats"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(homeScreenMostViewedProgrammes, forKey: .homeScreenMostViewedProgrammes)
    }
    
    init() {
        homeScreenMostViewedProgrammes = [HomeMostViewedData]()
        print("CCCC", homeScreenMostViewedProgrammes)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homeScreenMostViewedProgrammes = try container.decodeIfPresent(Array<HomeMostViewedData>.self, forKey: .homeScreenMostViewedProgrammes) ?? [HomeMostViewedData]()
        print("QQQ", [HomeMostViewedData]())
    }
}

struct HomeMostViewedData: Codable {
    typealias Identifier = String
    
    let count: String?
    let seriesName: String?
    let programName: String?
    let episodeNumber: String?
    let caption: String?
    let homeScreenMostViewedPreviewImageURLString: String
    let time: String?
    let id: String?
    let sid: String?
    let cid: String?
        
    
    enum CodingKeys: String, CodingKey {
        
        
        case count = "count"
        case seriesName = "series_name"
        case programName = "program_name"
        case episodeNumber = "episode_number"
        case caption = "caption"
        case imagePath = "image_path"
        case time = "time"
        case id = "id"
        case sid = "sid"
        case cid = "cid"

      
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
     
        try container.encode(count, forKey: .count)
        try container.encode(seriesName, forKey: .seriesName)
        try container.encode(programName, forKey: .programName)
        try container.encode(episodeNumber, forKey: .episodeNumber)
        try container.encode(caption, forKey: .caption)
        try container.encode(homeScreenMostViewedPreviewImageURLString, forKey: .imagePath)
        try container.encode(time, forKey: .time)
        try container.encode(id, forKey: .id)
        try container.encode(sid, forKey: .sid)
        try container.encode(cid, forKey: .cid)
    }
    
    init() {
        
        self.count = ""
        self.seriesName = ""
        self.programName = ""
        self.episodeNumber = ""
        self.caption = ""
        self.homeScreenMostViewedPreviewImageURLString = ""
        self.time = ""
        self.id = ""
        self.sid = ""
        self.cid = ""
        print(self.homeScreenMostViewedPreviewImageURLString)
        
    
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(String.self, forKey: .count) ?? ""
        seriesName = try container.decodeIfPresent(String.self, forKey: .seriesName) ?? ""
        programName = try container.decodeIfPresent(String.self, forKey: .programName) ?? ""
        episodeNumber = try container.decodeIfPresent(String.self, forKey: .episodeNumber) ?? ""
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        homeScreenMostViewedPreviewImageURLString = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
        cid = try container.decodeIfPresent(String.self, forKey: .cid) ?? ""
    }
}

