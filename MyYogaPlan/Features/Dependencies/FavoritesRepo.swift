//
//  FavoritesRepo.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import ComposableArchitecture
import Foundation
import MyYogaCore
import Combine

struct FavoritesRepo {
    var favorites: [YogaPose]
    var save: (YogaPose) -> Void
    var favoritesPublisher: AnyPublisher<[YogaPose], Never>
}

extension FavoritesRepo: DependencyKey {
    static var liveValue: FavoritesRepo {
        let localStore: FavoritePosesLocalStore = FilePersistenceManager<[YogaPose]>(subdirectory: "FavoritesPoses")
        
        let localData = localStore.favorites
        
        return Self(
            favorites: localData ?? [],
            save: { pose in
                localStore.update(pose)
            }, favoritesPublisher: localStore
                .valueUpdatePublisher
                .eraseToAnyPublisher()
        )
    }
}

extension DependencyValues {
    var favoritesRepo: FavoritesRepo {
        get { self[FavoritesRepo.self] }
        set { self[FavoritesRepo.self] = newValue }
    }
}

extension Array where Element: Identifiable {
    mutating func updateOrAppend(_ item: Element) {
        if let index = firstIndex(where: { $0.id == item.id }) {
            // If the item already exists, update it
            self[index] = item
        } else {
            // If the item doesn't exist, append it to the array
            append(item)
        }
    }
    
    mutating func delete(_ item: Element) {
        guard let index = firstIndex(where: { $0.id == item.id }) else {
            print("Failed to find matching element at a matching index.")
            return
        }
        self.remove(at: index)
    }
}
