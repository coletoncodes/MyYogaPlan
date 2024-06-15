//
//  FavoritePosesFeature.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FavoritePosesFeature {
    @ObservableState
    struct State: Equatable {
        var favoritePoses: [YogaPose] = []
    }
    
    enum Action: Equatable {
        case loadFavorites
        case favoritesLoaded([YogaPose])
        case didFavoritePose(YogaPose)
        case favoritesUpdated([YogaPose])
    }
    
    @Dependency(\.favoritesRepo) private var favorites
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadFavorites:
                return .publisher {
                    favorites.favoritesPublisher
                        .map(Action.favoritesLoaded)
                }
                
            case let .favoritesLoaded(favoritePoses):
                state.favoritePoses = favoritePoses
                return .none
                
            case let .didFavoritePose(pose):
                favorites.save(pose)
                return .none

            case let .favoritesUpdated(favoritePoses):
                state.favoritePoses = favoritePoses
                return .none
            }
        }
    }
}
