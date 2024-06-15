//
//  FavoritePosesLocalStore.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import MyYogaCore
import Foundation

protocol FavoritePosesLocalStore {
    func save(_ object: [YogaPoseDTO])
    var favorites: [YogaPoseDTO]? { get }
}

extension FilePersistenceManager<[YogaPoseDTO]>: FavoritePosesLocalStore {
    var favorites: [YogaPoseDTO]? {
        self.data
    }
}
