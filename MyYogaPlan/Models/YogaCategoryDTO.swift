//
//  YogaCategoryDTO.swift
//  
//
//  Created by Coleton Gorecke on 10/10/24.
//

import Foundation

public struct YogaCategoryDTO: Codable {
    let id: Int
    let categoryName, categoryDescription: String
    let poses: [YogaPoseDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case categoryDescription = "category_description"
        case poses
    }

    var asYogaCategory: YogaCategory {
        YogaCategory(
            id: self.id,
            name: self.categoryName,
            description: self.categoryDescription,
            poses: self.poses.map(\.asYogaPose)
        )
    }
}
