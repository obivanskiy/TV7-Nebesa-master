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
    static var searchEpisodeURL: String = "get_tv7_program_info/?program_id="
    
    //MARK: - HomeScreen endpoints
    static var homeScreenDataURL: String = "get_tv7_vod_recommendations/?date=2019-04-22"
    static var homeScreenNewestProgrammesURL: String = "get_tv7_vod_new?"
    //limit=40&offset=0
    static var homeScreenMostViewedProgrammesURL: String = "get_tv7_vod_previousweek_stats?vod=RU1"
    static var programmeInfoURL: String = "get_tv7_program_info?program_id="
    //65915
    
    //MARK: - Video playback endpoints
    static var baseURLForVideoPlayback: String = "https://vod.tv7.fi:443/vod-appletv/_definst_/mp4:"
    static var playlistEndpoint: String = "/chunklist.m3u8"
    
    //MARK: - Live streams endpoints
    static var webTVVideoStreamBaseURL: String = "https://vod.tv7.fi:443/"
    static var webTVStreamRUEndpoint: String = "tv7-ru/_definst_/smil:tv7-ru.smil/playlist.m3u8"

    //MARK: - Search results endpoints
    static var searchBaseURL: String = "http://edom.tv7.fi:8084/search1.1/SearchServlet"
    static var searchResultsURL: String = "?vod=RU1&query="
}
