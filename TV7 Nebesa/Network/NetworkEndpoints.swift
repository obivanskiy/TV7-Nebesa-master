//
//  NetworkEndpoints.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct NetworkEndpoints {
    static var baseURL: String = "https://sandbox.tv7.fi"
    static var categoryDataURL: String = "/nebesa/api/jed/get_tv7_category_programs/?category_id="
    static var categoryNameURL: String = "/nebesa/api/jed/get_tv7_parent_categories/"
    static var tvGuide: String = "/nebesa/api/jed/get_tv7_tv_guide_date/?date=2019-03-18"
}
