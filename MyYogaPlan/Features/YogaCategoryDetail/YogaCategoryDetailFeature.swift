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
        case posesUpdated([YogaPose])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadPoses:
                let favoritePoseIDs = Set(state.favoritePosesState.favoritePoses.map { $0.id })
                state.poses = state.category.poses.map { pose in
                    var updatedPose = pose
                    updatedPose.isFavorite = favoritePoseIDs.contains(pose.id)
                    return updatedPose
                }
                return .none
                
            case let .didFavoritePose(pose):
                return .concatenate(
                    .send(.favoritePosesAction(.didFavoritePose(pose))),
                    .send(.loadPoses)
                )
                
            case let .favoritePosesAction(favoriteAction):
                return FavoritePosesFeature().reduce(
                    into: &state.favoritePosesState,
                    action: favoriteAction
                )
                .map { _ in .loadPoses }
                
            case let .posesUpdated(poses):
                state.poses = poses
                return .none
            }
        }
    }
}
