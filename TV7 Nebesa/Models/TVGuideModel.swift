//
//  TVGuideModel.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 3/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


struct TVGuideDates: Decodable {
    let tvGuideDates: [TVGuideDatesData]

    enum CodingKeys: String, CodingKey {
        case tvGuideDates = "tv7_tv_guide_date"
    }

    init() {
        tvGuideDates = [TVGuideDatesData]()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tvGuideDates = try container.decodeIfPresent(Array<TVGuideDatesData>.self, forKey: .tvGuideDates) ?? [TVGuideDatesData]()
    }
}

struct TVGuideDatesData: Decodable {
    typealias Identifier = String

    let id: Identifier
    let episodeNumber: String
    let name: String
    let caption: String
    let sid: String
    let visibleOnVodSince: String?
    let isVisibleOnVod: String?
    let firstBroadcast: String
    let date: String
    let time: String
    let endTime: String
    let broadcastType: String
    let primaryTimezoneId: String
    let path: String
    let imagePath: String
    let category: String
    let cid: String
    let series: String
    let isLive: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case episodeNumber = "episode_number"
        case name = "name"
        case caption = "caption"
        case sid = "sid"
        case visibleOnVodSince = "visible_on_vod_since"
        case isVisibleOnVod = "is_visible_on_vod"
        case firstBroadcast = "first_broadcast"
        case date = "date"
        case time = "time"
        case endTime = "end_time"
        case broadcastType = "broadcast_type"
        case primaryTimezoneId = "primary_timezone_id"
        case path = "path"
        case imagePath = "image_path"
        case category = "category"
        case cid = "cid"
        case series = "series"
        case isLive = "is_live"
    }

    init() {
        self.id = ""
        self.episodeNumber = ""
        self.name = ""
        self.caption = ""
        self.sid = ""
        self.visibleOnVodSince = ""
        self.isVisibleOnVod = ""
        self.firstBroadcast = ""
        self.date = ""
        self.time = ""
        self.endTime = ""
        self.broadcastType = ""
        self.primaryTimezoneId = ""
        self.path = ""
        self.imagePath = ""
        self.category = ""
        self.cid = ""
        self.series = ""
        self.isLive = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        episodeNumber = try container.decodeIfPresent(String.self, forKey: .episodeNumber) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
        visibleOnVodSince = try container.decodeIfPresent(String.self, forKey: .visibleOnVodSince) ?? ""
        isVisibleOnVod = try container.decodeIfPresent(String.self, forKey: .isVisibleOnVod) ?? ""
        firstBroadcast = try container.decodeIfPresent(String.self, forKey: .firstBroadcast) ?? ""
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        endTime = try container.decodeIfPresent(String.self, forKey: .endTime) ?? ""
        broadcastType = try container.decodeIfPresent(String.self, forKey: .broadcastType) ?? ""
        primaryTimezoneId = try container.decodeIfPresent(String.self, forKey: .primaryTimezoneId) ?? ""
        path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        cid = try container.decodeIfPresent(String.self, forKey: .cid) ?? ""
        series = try container.decodeIfPresent(String.self, forKey: .series) ?? ""
        isLive = try container.decodeIfPresent(String.self, forKey: .isLive) ?? ""
    }
}
