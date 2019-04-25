//
//  HomeScreenMostViewedProgrammes.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/9/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct HomeScreenNewestProgrammes: Codable {
    
    let homeScreenNewestProgrammes: [HomeNewestData]
    
    enum CodingKeys: String, CodingKey {
        case homeScreenNewestProgrammes = "tv7_vod_new"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(homeScreenNewestProgrammes, forKey: .homeScreenNewestProgrammes)
    }
    
    init() {
        homeScreenNewestProgrammes = [HomeNewestData]()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homeScreenNewestProgrammes = try container.decodeIfPresent(Array<HomeNewestData>.self, forKey: .homeScreenNewestProgrammes) ?? [HomeNewestData]()
    }
    }
    
    struct HomeNewestData: Codable {
        typealias Identifier = String
        
        let id: Identifier
        let episodeNumber: String?
        let name: String?
        let caption: String?
        let duration: String?
        let sid: String?
        let sname: String?
        let seriesName: String
        let cid: String?
        let cname: String?
        let firstBroadcast: String
        let fcname: String?
        let time: String?
        let startDate: String?
        let path: String?
        let linkPath: String?
        let homeScreenNewestPreviewImageURLString: String
        
        
        
        enum CodingKeys: String, CodingKey {
            
            case id = "id"
            case episodeNumber = "episode_number"
            case name = "name"
            case caption = "caption"
            case duration = "duration"
            case sid = "sid"
            case sname = "sname"
            case seriesName = "series_name"
            case cid = "cid"
            case cname = "cname"
            case firstBroadcast = "first_broadcast"
            case fcname = "fcname"
            case time = "time"
            case startDate = "start_date"
            case path = "path"
            case linkPath = "link_path"
            case imagePath = "image_path"
            
        }
        
        func encode(to encoder: Encoder) throws {
            
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(episodeNumber, forKey: .episodeNumber)
            try container.encode(name, forKey: .name)
            try container.encode(caption, forKey: .caption)
            try container.encode(duration, forKey: .duration)
            try container.encode(sid, forKey: .sid)
            try container.encode(sname, forKey: .sname)
            try container.encode(seriesName, forKey: .seriesName)
            try container.encode(cid, forKey: .cid)
            try container.encode(cname, forKey: .cname)
            try container.encode(firstBroadcast, forKey: .firstBroadcast)
            try container.encode(fcname, forKey: .fcname)
            try container.encode(time, forKey: .time)
            try container.encode(startDate, forKey: .startDate)
            try container.encode(path, forKey: .path)
            try container.encode(linkPath, forKey: .linkPath)
            try container.encode(homeScreenNewestPreviewImageURLString, forKey: .imagePath)

            
        }
        
        init() {
            self.id = ""
            self.episodeNumber = ""
            self.name = ""
            self.caption = ""
            self.duration = ""
            self.sid = ""
            self.sname = ""
            self.seriesName = ""
            self.cid = ""
            self.cname = ""
            self.firstBroadcast = ""
            self.fcname = ""
            self.time = ""
            self.startDate = ""
            self.path = ""
            self.linkPath = ""
            self.homeScreenNewestPreviewImageURLString = ""
           
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
            episodeNumber = try container.decodeIfPresent(String.self, forKey: .episodeNumber) ?? ""
    
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
            
            duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
            sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
            sname = try container.decodeIfPresent(String.self, forKey: .sname) ?? ""
            seriesName = try container.decodeIfPresent(String.self, forKey: .seriesName) ?? ""
            cid = try container.decodeIfPresent(String.self, forKey: .cid) ?? ""
            cname = try container.decodeIfPresent(String.self, forKey: .cname) ?? ""
            firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
            fcname = try container.decodeIfPresent(String.self, forKey: .fcname) ?? ""
            time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
            startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? ""
            path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
            linkPath = try container.decodeIfPresent(String.self, forKey: .linkPath) ?? ""
            homeScreenNewestPreviewImageURLString = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
           
}

}
