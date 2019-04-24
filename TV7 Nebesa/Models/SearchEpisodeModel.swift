//
//  SearchEpisodeModel.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/23/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct SearchEpisode: Decodable {
    let results: [SearchEpisodeData]

    enum CodingKeys: String, CodingKey {
        case searchEpisode = "tv7_program_info"
    }

    init() {
        results = [SearchEpisodeData]()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent(Array<SearchEpisodeData>.self, forKey: .searchEpisode) ?? [SearchEpisodeData]()
    }
}

struct SearchEpisodeData: Decodable {
    typealias Identifier = String

    let id: Identifier
    let episodeNumber: String
    let name: String
    let caption: String
    let description: String
    let aspectRatio: String
    let cid: String
    let firstBroadcast: String
    let fcname: String
    let time: String
    let startDate: String
    let sid: String
    let sname: String
    let path: String
    let imagePath: String
    let duration: String
    let lastBroadcast: String
    let visibleOnVodSince: String
    let isVisibleOnVod: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case episodeNumber = "episode_number"
        case name = "name"
        case caption = "caption"
        case description = "description"
        case aspectRatio = "aspect_ratio"
        case cid = "cid"
        case firstBroadcast = "first_broadcast"
        case fcname = "fcname"
        case time = "time"
        case startDate = "start_date"
        case sid = "sid"
        case sname = "sname"
        case path = "path"
        case imagePath = "image_path"
        case duration = "duration"
        case lastBroadcast = "last_broadcast"
        case visibleOnVodSince = "visible_on_vod_since"
        case isVisibleOnVod = "is_visible_on_vod"
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
        self.fcname = ""
        self.time = ""
        self.startDate = ""
        self.sid = ""
        self.sname = ""
        self.path = ""
        self.imagePath = ""
        self.duration = ""
        self.lastBroadcast = ""
        self.visibleOnVodSince = ""
        self.isVisibleOnVod = ""

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
        fcname = try container.decodeIfPresent(String.self, forKey: .fcname) ?? ""
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? ""
        sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
        sname = try container.decodeIfPresent(String.self, forKey: .sname) ?? ""
        path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        lastBroadcast = try container.decodeIfPresent(String.self, forKey: .lastBroadcast) ?? ""
        visibleOnVodSince = try container.decodeIfPresent(String.self, forKey: .visibleOnVodSince) ?? ""
        isVisibleOnVod = try container.decodeIfPresent(String.self, forKey: .isVisibleOnVod) ?? ""
    }
}
