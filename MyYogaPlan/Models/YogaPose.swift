//
//  YogaPose.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation

struct YogaPose: Codable, Identifiable, Hashable, Equatable {
    let id: Int
    let name: String
    let description: String
    let urlPNG: String
    let benefits: [String]
    var isFavorite: Bool = false
    
    init(
        id: Int,
        name: String,
        description: String,
        urlPNG: String,
        benefits: [String],
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.urlPNG = urlPNG
        self.benefits = benefits
        self.isFavorite = isFavorite
    }
}
