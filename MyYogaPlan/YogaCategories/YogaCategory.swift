//
//  YogaCategory.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import Foundation

struct YogaCategory: Equatable, Identifiable, Codable {
    var id: String
    var name: String
    var description: String
    var poses: [YogaPose]
}

struct YogaPose: Equatable, Identifiable, Codable {
    var id: String
    var name: String
    var difficulty: String
}
