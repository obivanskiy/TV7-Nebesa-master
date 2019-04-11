//
//  NetworkEndpoints.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct NetworkEndpoints {
    //MARK: - Main request endpoints
    static var baseURL: String = "https://www.nebesatv7.com/api/jed/"
    static var categoryDataURL: String = "get_tv7_category_programs?category_id="
    static var parentCategoriesURL: String = "get_tv7_parent_categories/"
    static var subCategoriesURL: String = "get_tv7_sub_categories/?parent_id="
    static var seriesInfoURL: String = "get_tv7_series_info?series_id="
    static var seriesProgrammesURL: String = "get_tv7_series_programs?series_id="
    static var webTVGuideURL: String = "get_tv7_tv_guide_date?date="
    static var tvGuide: String = "get_tv7_tv_guide_date/?date="
    
    //MARK: - Video playback endpoints
    static var baseURLForVideoPlayback: String = "https://vod.tv7.fi:443/vod-appletv/_definst_/mp4:"
    static var playlistEndpoint: String = "/chunklist.m3u8"
    
    //MARK: - Live streams endpoints
    static var webTVVideoStreamBaseURL: String = "https://vod.tv7.fi:443/"
    static var webTVStreamRUEndpoint: String = "tv7-ru/_definst_/smil:tv7-ru.smil/playlist.m3u8"
    
}
