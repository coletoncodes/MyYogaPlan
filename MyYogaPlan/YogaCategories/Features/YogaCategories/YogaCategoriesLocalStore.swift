//
//  YogaCategoriesLocalStore.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation
import MyYogaCore

protocol YogaCategoriesLocalStore {
    func save(_ object: [YogaCategoryDTO])
    var data: [YogaCategoryDTO]? { get }
}

extension FilePersistenceManager<[YogaCategoryDTO]>: YogaCategoriesLocalStore {
}
