//
//  FavoritePosesLocalStore.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Combine
import MyYogaCore
import Foundation

protocol FavoritePosesLocalStore {
    func save(_ object: [YogaPose])
    var favorites: [YogaPose]? { get }
    func remove(_ pose: YogaPose)
    
    var valueUpdatePublisher: AnyPublisher<[YogaPose], Never> { get }
}

extension FilePersistenceManager<[YogaPose]>: FavoritePosesLocalStore {
    var favorites: [YogaPose]? {
        self.data
    }
    
    func remove(_ pose: YogaPose) {
        if var data = self.data{
            data.removeAll(where: { $0.id == pose.id })
            self.save(data)
        }
    }
}
