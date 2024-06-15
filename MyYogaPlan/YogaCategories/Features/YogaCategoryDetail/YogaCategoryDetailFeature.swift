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
        
        var poses: [YogaPose] {
            category.poses
        }
    }
    
    enum Action {
        case didTapPose
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .didTapPose:
                return .none
            }
        }
    }
}
