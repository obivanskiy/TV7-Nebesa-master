//
//  CategoriesDataModel.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct CategoryProgrammes: Codable {
    let categoryProgrammes: [CategoryProgrammesData]
    
    enum CodingKeys: String, CodingKey {
        case categoryProgrammes = "tv7_category_programs"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categoryProgrammes, forKey: .categoryProgrammes)
    }
    
    init() {
        categoryProgrammes = [CategoryProgrammesData]()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categoryProgrammes = try container.decodeIfPresent(Array<CategoryProgrammesData>.self, forKey: .categoryProgrammes) ?? [CategoryProgrammesData]()
    }
}

struct CategoryProgrammesData: Codable {
    typealias Identifier = String
    
    let id: Identifier
    let name: String
    let caption: String
    let videoPreviewImageURLString: String
    let sid: String?
    let language: String
    let visibleOnVodSince: String
    let linkPath: String
    let description: String?
    let play: String
    let duration: String
    let firstBroadcast: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case caption = "caption"
        case imagePath = "image_path"
        case sid = "sid"
        case language = "language"
        case visibleOnVodSince = "visible_on_vod_since"
        case linkPath = "link_path"
        case description = "description"
        case play = "play"
        case duration = "duration"
        case firstBroadcast = "first_broadcast"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(caption, forKey: .caption)
        try container.encode(videoPreviewImageURLString, forKey: .imagePath)
        try container.encode(sid, forKey: .sid)
        try container.encode(language, forKey: .language)
        try container.encode(visibleOnVodSince, forKey: .visibleOnVodSince)
        try container.encode(linkPath, forKey: .linkPath)
        try container.encode(description, forKey: .description)
        try container.encode(play, forKey: .play)
        try container.encode(duration, forKey: .duration)
        try container.encode(firstBroadcast, forKey: .firstBroadcast)
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.caption = ""
        self.videoPreviewImageURLString = ""
        self.sid = ""
        self.language = ""
        self.visibleOnVodSince = ""
        self.linkPath = ""
        self.description = ""
        self.play = ""
        self.duration = ""
        self.firstBroadcast = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        videoPreviewImageURLString = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
        language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        visibleOnVodSince = try container.decodeIfPresent(String.self, forKey: .visibleOnVodSince) ?? ""
        linkPath = try container.decodeIfPresent(String.self, forKey: .linkPath) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        play = try container.decodeIfPresent(String.self, forKey: .play) ?? ""
        duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
    }
}
