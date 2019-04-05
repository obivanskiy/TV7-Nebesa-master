//
//  SubCategoriesModel.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct SubCategories: Codable {
    
    let subCategories: [SubCategoriesDetails]
    
    enum CodingKeys: String, CodingKey {
        case subCategories = "tv7_sub_categories"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subCategories, forKey: .subCategories)
    }
    
    init() {
        subCategories = [SubCategoriesDetails]()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        subCategories = try container.decodeIfPresent(Array<SubCategoriesDetails>.self, forKey: .subCategories) ?? [SubCategoriesDetails]()
    }
}

struct SubCategoriesDetails: Codable {
    typealias Identifier = String
    
    let parentID: Identifier
    let parentName: String
    let parentDescription: String?
    let categoryID: String
    let categoryName: String
    let categoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case parentID = "parent_id"
        case parentName = "parent_name"
        case parentDescription = "parent_description"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case categoryDescription = "category_description"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(parentID, forKey: .parentID)
        try container.encode(parentName, forKey: .parentName)
        try container.encode(categoryID, forKey: .categoryID)
        try container.encode(categoryName, forKey: .categoryName)
    }
    
    init() {
        self.parentID = ""
        self.parentName = ""
        self.parentDescription = nil
        self.categoryID = ""
        self.categoryName = ""
        self.categoryDescription = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        parentID = try container.decodeIfPresent(Identifier.self, forKey: .parentID) ?? ""
        parentName = try container.decodeIfPresent(String.self, forKey: .parentName) ?? ""
        parentDescription = try container.decodeIfPresent(String.self, forKey: .parentDescription) ?? nil
        categoryID = try container.decodeIfPresent(Identifier.self, forKey: .categoryID) ?? ""
        categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName) ?? ""
        categoryDescription = try container.decodeIfPresent(String.self, forKey: .categoryDescription) ?? nil
    }
}
