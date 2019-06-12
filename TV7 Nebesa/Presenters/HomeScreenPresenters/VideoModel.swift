//
//  VideoModel.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 6/4/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


struct Video: Decodable {
    var id: String?
    var title: String?
    var seriesName: String?
    var description: String?
    var caption: String?
    var episodeNumber: String?
    var duration: String?
    var visibleSince: String?
    var thumbnailImage: String?
    var videoUrl: String?
}
