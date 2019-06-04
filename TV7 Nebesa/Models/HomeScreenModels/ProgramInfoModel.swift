//
//  ProgramInfoModel.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/8/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


struct HomeScreenProgrammeInformation: Codable {
    let homeProgrammeInfo: [ProgrammeInfo]
    
    enum CodingKeys: String, CodingKey{
        case homeProgrammeInfo = "tv7_program_info"
    }
    
    init() {
        homeProgrammeInfo = [ProgrammeInfo]()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(homeProgrammeInfo, forKey: .homeProgrammeInfo)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homeProgrammeInfo = try container.decodeIfPresent(Array<ProgrammeInfo>.self, forKey: .homeProgrammeInfo) ?? [ProgrammeInfo]()
    }
}

struct ProgrammeInfo: Codable {
    typealias Identifier = String
    
    let id: Identifier
    let episodeNumber: String
    let name: String?
    let caption: String
    let description: String
    let aspectRatio: String
    let cid: String
    let firstBroadcast: String
    let fcName: String
    let time: String
    let startDate: String
    let sid: String
    let sname: String
    let path: String
    let imagePath: String
    let duration: String
    let lastBroadcast: String
    let onVODSince: String
    let isVisibleOnVOD: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case episodeNumber = "episode_number"
        case name = "name"
        case caption = "caption"
        case description = "description"
        case aspectRatio = "aspect_ratio"
        case cid = "cid"
        case firstBroadcast = "first_broadcast"
        case fcName = "fcname"
        case time = "time"
        case startDate = "start_date"
        case sid = "sid"
        case sname = "sname"
        case path = "path"
        case imagePath = "image_path"
        case duration = "duration"
        case lastBroadcast = "last_broadcast"
        case onVODSince = "visible_on_vod_since"
        case isVisibleOnVOD = "is_visible_on_vod"
        
    }
    
    init() {
        self.id = ""
        self.episodeNumber = ""
        self.name = ""
        self.caption = ""
        self.description = ""
        self.aspectRatio = ""
        self.cid = ""
        self.firstBroadcast = ""
        self.fcName = ""
        self.time = ""
        self.startDate = ""
        self.sid = ""
        self.sname = ""
        self.path = ""
        self.imagePath = ""
        self.duration = ""
        self.lastBroadcast = ""
        self.onVODSince = ""
        self.isVisibleOnVOD = ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(episodeNumber, forKey: .episodeNumber)
        try container.encode(name, forKey: .name)
        try container.encode(caption, forKey: .caption)
        try container.encode(description, forKey: .description)
        try container.encode(aspectRatio, forKey: .aspectRatio)
        try container.encode(cid, forKey: .cid)
        try container.encode(firstBroadcast, forKey: .firstBroadcast)
        try container.encode(fcName, forKey: .fcName)
        try container.encode(time, forKey: .time)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(sid, forKey: .sid)
        try container.encode(sname, forKey: .sname)
        try container.encode(path, forKey: .path)
        try container.encode(imagePath, forKey: .imagePath)
        try container.encode(duration, forKey: .duration)
        try container.encode(lastBroadcast, forKey: .lastBroadcast)
        try container.encode(onVODSince, forKey: .onVODSince)
        try container.encode(isVisibleOnVOD, forKey: .isVisibleOnVOD)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        episodeNumber = try container.decodeIfPresent(String.self, forKey: .episodeNumber) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        aspectRatio = try container.decodeIfPresent(String.self, forKey: .aspectRatio) ?? ""
        cid = try container.decodeIfPresent(String.self, forKey: .cid) ?? ""
        firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
        fcName = try container.decodeIfPresent(String.self, forKey: .fcName) ?? ""
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? ""
        sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
        sname = try container.decodeIfPresent(String.self, forKey: .sname) ?? ""
        path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        lastBroadcast = try container.decodeIfPresent(String.self, forKey: .lastBroadcast) ?? ""
        onVODSince = try container.decodeIfPresent(String.self, forKey: .onVODSince) ?? ""
        isVisibleOnVOD = try container.decodeIfPresent(String.self, forKey: .isVisibleOnVOD) ?? ""
    }
}


