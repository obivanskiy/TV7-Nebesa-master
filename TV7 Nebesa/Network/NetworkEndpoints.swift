//
//  NetworkEndpoints.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct NetworkEndpoints {

    static var baseURL: String = "https://www.nebesatv7.com/api/jed/"
    static var categoryDataURL: String = "get_tv7_category_programs?category_id="
    static var parentCategoriesURL: String = "get_tv7_parent_categories/"
    static var subCategoriesURL: String = "get_tv7_sub_categories/?parent_id="
    static var seriesInfoURL: String = "get_tv7_series_info?series_id=52761"
    static var tvGuide: String = "get_tv7_tv_guide_date/?date=2019-03-18"
    
    static var homeScreenDataURL: String = "get_tv7_vod_recommendations/?date=2019-04-08"
    
    
    //MARK: - Video playback endpoints
    static var baseURLForVideoPlayback: String = "https://vod.tv7.fi:443/vod-appletv/_definst_/mp4:"
    static var playlistEndpoint: String = "/chunklist.m3u8"
    
}

