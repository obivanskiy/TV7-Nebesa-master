//
//  HomeScreenDataModel.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/20/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct HomeScreenProgrammes: Codable {
    
    let homeScreenProgrammes: [HomeScreenData]
    
    enum CodingKeys: String, CodingKey {
        case homeScreenProgrammes = "tv7_vod_recommendations"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(homeScreenProgrammes, forKey: .homeScreenProgrammes)
    }
    
    init() {
        homeScreenProgrammes = [HomeScreenData]()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homeScreenProgrammes = try container.decodeIfPresent(Array<HomeScreenData>.self, forKey: .homeScreenProgrammes) ?? [HomeScreenData]()
    }
}
    
    struct HomeScreenData: Codable {
        typealias Identifier = String
        
        let id: Identifier
        let sid: String?
        let name: String
        let caption: String
        let firstBroadcast: String
        let episodeNumber: String
        let duration: String
        let description: String?
        let fcname: String?
        let linkPath: String
        let homeScreenVideoPreviewImageURLString: String
        let seriesName: String
        let visibleOnVodSince: String
       
        
        enum CodingKeys: String, CodingKey {
            
            case id = "id"
            case sid = "sid"
            case name = "name"
            case caption = "caption"
            case firstBroadcast = "first_broadcast"
            case episodeNumber = "episode_number"
            case duration = "duration"
            case description = "description"
            case fcname = "fcname"
            case linkPath = "link_path"
            case imagePath = "image_path"
            case seriesName = "series_name"
            case visibleOnVodSince = "visible_on_vod_since"
       
        }
        
        func encode(to encoder: Encoder) throws {
            
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(sid, forKey: .sid)
            try container.encode(name, forKey: .name)
            try container.encode(caption, forKey: .caption)
            
            try container.encode(firstBroadcast, forKey: .firstBroadcast)
            try container.encode(episodeNumber, forKey: .episodeNumber)
            try container.encode(duration, forKey: .duration)
            try container.encode(description, forKey: .description)
            try container.encode(fcname, forKey: .fcname)
            try container.encode(linkPath, forKey: .linkPath)
            try container.encode(homeScreenVideoPreviewImageURLString, forKey: .imagePath)
            try container.encode(seriesName, forKey: .seriesName)
            try container.encode(visibleOnVodSince, forKey: .visibleOnVodSince)
           
        
        }
        
        init() {
            self.id = ""
            self.sid = ""
            self.name = ""
            self.caption = ""
            self.firstBroadcast = ""
            self.episodeNumber = ""
            self.duration = ""
            self.description = ""
            self.fcname = ""
            self.linkPath = ""
            self.homeScreenVideoPreviewImageURLString = ""
            self.seriesName = ""
            self.visibleOnVodSince = ""
        
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
            sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
            firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
            episodeNumber = try container.decodeIfPresent(String.self, forKey: .episodeNumber) ?? ""
            duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
            description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
            fcname = try container.decodeIfPresent(String.self, forKey: .fcname) ?? ""
            linkPath = try container.decodeIfPresent(String.self, forKey: .linkPath) ?? ""
            homeScreenVideoPreviewImageURLString = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
            seriesName = try container.decodeIfPresent(String.self, forKey: .seriesName) ?? ""
            visibleOnVodSince = try container.decodeIfPresent(String.self, forKey: .visibleOnVodSince) ?? ""
            
        }
}

