//
//  SeriesInfoModel.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


struct ProgrammeInformation: Codable {
    let programmeInfo: [SeriesInfo]
    
    enum CodingKeys: String, CodingKey{
        case programmeInfo = "tv7_series_info" 
    }
    
    init() {
        programmeInfo = [SeriesInfo]()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(programmeInfo, forKey: .programmeInfo)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        programmeInfo = try container.decodeIfPresent(Array<SeriesInfo>.self, forKey: .programmeInfo) ?? [SeriesInfo]()
    }
}

struct SeriesInfo: Codable {
    typealias Identifier = String
    
    let id: Identifier
    let caption: String
    let description: String
    let name: String
    let language: String
    let imagePath: String
    let cid: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case caption = "caption"
        case description = "description"
        case name = "name"
        case language = "language"
        case imagePath = "image_path"
        case cid = "cid"
    }
    
    init() {
        self.id = ""
        self.caption = ""
        self.description = ""
        self.name = ""
        self.language = ""
        self.imagePath = ""
        self.cid = ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(caption, forKey: .caption)
        try container.encode(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encode(language, forKey: .language)
        try container.encode(imagePath, forKey: .imagePath)
        try container.encode(cid, forKey: .cid)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        cid = try container.decodeIfPresent(String.self, forKey: .cid) ?? ""
    }
    
}


