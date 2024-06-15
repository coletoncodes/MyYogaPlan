//
//  YogaCategory.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import Foundation

struct YogaCategory: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let categoryName, categoryDescription: String
    let poses: [YogaPose]
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case categoryDescription = "category_description"
        case poses
    }
}
