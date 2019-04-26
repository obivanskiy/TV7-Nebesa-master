//
//  SeriesProgrammesModel.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/20/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct SeriesProgrammes: Codable {
    let seriesProgrammes: [ProgrammesData]
    
    enum CodingKeys: String, CodingKey {
        case seriesProgrammes = "tv7_series_programs"
    }
    
    init() {
        seriesProgrammes = [ProgrammesData]()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(seriesProgrammes, forKey: .seriesProgrammes)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        seriesProgrammes = try container.decodeIfPresent(Array<ProgrammesData>.self, forKey: .seriesProgrammes) ?? [ProgrammesData]()
    }
}

struct ProgrammesData: Codable {
    typealias Identifier = String
    
    let id: Identifier
    let episodeNumber: String
    let name: String
    let caption: String
    let description: String
    let aspectRatio: String
    let duration: String
    let firstBroadcast: String
    let fcName: String
    let sid: String
    let seriesName: String
    let path: String
    let linkPath: String
    let imagePath: String
    let onVODSince: String
    let isVisibleOnVOD: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case episodeNumber = "episode_number"
        case name = "name"
        case caption = "caption"
        case description = "description"
        case aspectRatio = "aspect_ratio"
        case duration = "duration"
        case firstBroadcast = "first_broadcast"
        case fcName = "fcname"
        case sid = "sid"
        case seriesName = "series_name"
        case path = "path"
        case linkPath = "link_path"
        case imagePath = "image_path"
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
        self.duration = ""
        self.firstBroadcast = ""
        self.fcName = ""
        self.sid = ""
        self.seriesName = ""
        self.path = ""
        self.linkPath = ""
        self.imagePath = ""
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
        try container.encode(duration, forKey: .duration)
        try container.encode(firstBroadcast, forKey: .firstBroadcast)
        try container.encode(fcName, forKey: .fcName)
        try container.encode(sid, forKey: .sid)
        try container.encode(seriesName, forKey: .seriesName)
        try container.encode(path, forKey: .path)
        try container.encode(linkPath, forKey: .linkPath)
        try container.encode(imagePath, forKey: .imagePath)
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
        duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
        fcName = try container.decodeIfPresent(String.self, forKey: .fcName) ?? ""
        sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
        seriesName = try container.decodeIfPresent(String.self, forKey: .seriesName) ?? ""
        path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        linkPath = try container.decodeIfPresent(String.self, forKey: .linkPath) ?? ""
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        onVODSince = try container.decodeIfPresent(String.self, forKey: .onVODSince) ?? ""
        isVisibleOnVOD = try container.decodeIfPresent(String.self, forKey: .isVisibleOnVOD) ?? ""
    }
}
