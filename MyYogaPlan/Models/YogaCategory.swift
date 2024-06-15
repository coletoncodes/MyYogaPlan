//
//  YogaCategory.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import Foundation

struct YogaCategory: Identifiable, Hashable, Equatable {
    let id: Int
    let name, description: String
    let poses: [YogaPose]
    
    init(
        id: Int,
        name: String,
        description: String,
        poses: [YogaPose]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.poses = poses
    }
}
