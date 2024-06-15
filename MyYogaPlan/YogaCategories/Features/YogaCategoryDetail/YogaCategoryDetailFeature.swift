//
//  YogaCategoryDetailFeature.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct YogaCategoryDetailFeature {
    @ObservableState
    struct State: Equatable {
        let category: YogaCategory
        var favoritePosesState: FavoritePosesFeature.State = .init()
        
        var poses: [YogaPose] = []
    }
    
    enum Action: Equatable {
        case loadPoses
        case didFavoritePose(YogaPose)
        case favoritePosesAction(FavoritePosesFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadPoses:
                let favorites = Set(state.favoritePosesState.favoritePoses.map { $0.id })
                state.poses = state.category.poses.map { pose in
                    var updatedPose = pose
                    updatedPose.isFavorite = favorites.contains(pose.id)
                    return updatedPose
                }
                return .none
                
            case let .didFavoritePose(pose):
                return .send(.favoritePosesAction(.didFavoritePose(pose)))
                
            case let .favoritePosesAction(favoriteAction):
                return FavoritePosesFeature().reduce(
                    into: &state.favoritePosesState,
                    action: favoriteAction
                )
                .map { _ in .loadPoses }
            }
        }
    }
}
