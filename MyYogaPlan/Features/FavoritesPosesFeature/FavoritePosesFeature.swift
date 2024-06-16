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
        @Shared(.fileStorage(.documentsDirectory.appending(component: "FavoritePoses")))
        var favoritePoses = Set<YogaPose>()
        
        var shouldShowFavorites: Bool = false
    }
    
    enum Action: Equatable {
        case favoritesLoaded(Set<YogaPose>)
        case didFavoritePose(YogaPose)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .favoritesLoaded(favoritePoses):
                state.favoritePoses = favoritePoses
                state.shouldShowFavorites = !favoritePoses.isEmpty
                return .none
                
            case var .didFavoritePose(pose):
                if state.favoritePoses.contains(pose) {
                    pose.isFavorite = false
                    state.favoritePoses.remove(pose)
                } else {
                    pose.isFavorite = true
                    state.favoritePoses.insert(pose)
                }
                return .send(.favoritesLoaded(state.favoritePoses))
            }
        }
    }
}
