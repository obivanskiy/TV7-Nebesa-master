//
//  SearchResultsModel.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/15/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


struct SearchResults {
    let searchResults: [SearchResultsData]

    enum CodingKeys: String, CodingKey {
        case searchResults = "results"
    }

    init() {
        searchResults = [SearchResultsData]()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        searchResults = try container.decodeIfPresent(Array<SearchResultsData>.self, forKey: .searchResults) ?? [SearchResultsData]()
    }
}

struct SearchResultsData: Decodable {
    typealias Identifier = String

    let id: Identifier
    let name: String
    let caption: String
    let description: String
    let seriesId: String
    let seriesName: String
    let seriesCaption: String
    let firstBroadcast: String
    let firstBroadcastChannel: String
    let duration: String
    let imagePath: String
    let type: String
    let spokenLang: String
    let relevant: String
    let vod: String
    let score: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case caption = "caprion"
        case description = "description"
        case seriesId = "series_id"
        case seriesName = "series_name"
        case seriesCaption = "series_caption"
        case firstBroadcast = "first_broadcast"
        case firstBroadcastChannel = "first_broadcast_channel"
        case duration = "duration"
        case imagePath = "image_path"
        case type = "type"
        case spokenLang = "spoken_lang"
        case relevant = "relevant"
        case vod = "vod"
        case score = "score"
    }

    init() {
        self.id = ""
        self.name = ""
        self.caption = ""
        self.description = ""
        self.seriesId = ""
        self.seriesName = ""
        self.seriesCaption = ""
        self.firstBroadcast = ""
        self.firstBroadcastChannel = ""
        self.duration = ""
        self.imagePath = ""
        self.type = ""
        self.spokenLang = ""
        self.relevant = ""
        self.vod = ""
        self.score = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        seriesId = try container.decodeIfPresent(String.self, forKey: .seriesId) ?? ""
        seriesName = try container.decodeIfPresent(String.self, forKey: .seriesName) ?? ""
        seriesCaption = try container.decodeIfPresent(String.self, forKey: .seriesCaption) ?? ""
        firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
        firstBroadcastChannel = try container.decodeIfPresent(String.self, forKey: .firstBroadcastChannel) ?? ""
        duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        spokenLang = try container.decodeIfPresent(String.self, forKey: .spokenLang) ?? ""
        relevant = try container.decodeIfPresent(String.self, forKey: .relevant) ?? ""
        vod = try container.decodeIfPresent(String.self, forKey: .vod) ?? ""
        score = try container.decodeIfPresent(String.self, forKey: .score) ?? ""
    }
}
