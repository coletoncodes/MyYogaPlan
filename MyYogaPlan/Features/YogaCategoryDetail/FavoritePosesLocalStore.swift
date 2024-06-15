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
    func update(_ pose: YogaPose)
    var favorites: [YogaPose]? { get }
    
    var valueUpdatePublisher: AnyPublisher<[YogaPose], Never> { get }
}

extension FilePersistenceManager<[YogaPose]>: FavoritePosesLocalStore {
    var favorites: [YogaPose]? {
        self.data
    }
    
    func update(_ pose: YogaPose) {
        var data = favorites
        if pose.isFavorite {
            data?.updateOrAppend(pose)
            if let data {
                self.save(data)
            }
        } else {
            self.remove(pose)
        }
    }
    
    private func remove(_ pose: YogaPose) {
        if var data = self.data{
            print("Removing pose: \(pose)")
            data.removeAll(where: { $0.id == pose.id })
            self.save(data)
        }
    }
}
