//
//  ParentalCategoriesModel.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct ParentCategories: Codable {
    let parentCategories: [CategoriesDetails]
    
    enum CodingKeys: String, CodingKey {
        case parentCategories = "tv7_parent_categories"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(parentCategories, forKey: .parentCategories)
    }
    
    init() {
        parentCategories = [CategoriesDetails]()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        parentCategories = try container.decodeIfPresent(Array<CategoriesDetails>.self, forKey: .parentCategories) ?? [CategoriesDetails]()
    }
}

struct CategoriesDetails: Codable {
    typealias Identifier = String
    
    let id: Identifier
    let name: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.description = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Identifier.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? nil
    }
}
