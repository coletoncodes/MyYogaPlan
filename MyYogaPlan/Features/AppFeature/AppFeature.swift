//
//  AppFeature.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct AppFeature {
    
    struct State: Equatable {
        var tab1 = YogaCategoriesFeature.State()
        var tab2 = FavoritePosesFeature.State()
    }
    
    enum Action {
        case tab1(YogaCategoriesFeature.Action)
        case tab2(FavoritePosesFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.tab1, action: \.tab1) {
            YogaCategoriesFeature()
        }
        
        Scope(state: \.tab2, action: \.tab2) {
            FavoritePosesFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
