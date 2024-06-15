//
//  YogaCategoriesFeature.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct YogaCategoriesFeature {
    @ObservableState
    struct State: Equatable {
        var categories: [YogaCategory] = []
        var isLoading: Bool = false
        var errorMessage: String?
        
        var path = StackState<YogaCategoryDetailFeature.State>()
    }
    
    enum Action {
        case fetchCategories
        case categoriesResponse([YogaCategory])
        case didSelectCategory(YogaCategory)
        case path(StackAction<YogaCategoryDetailFeature.State, YogaCategoryDetailFeature.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case selectCategory(YogaCategoryDetailFeature)
    }
    
    @Dependency(\.yogaCategoriesRepo) private var repo
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCategories:
                state.isLoading = true
                return .run { send in
                    do {
                        let categories = try await repo.fetchCategories()
                        await send(.categoriesResponse(categories))
                    } catch {
                        await send(.categoriesResponse([]))
                    }
                }
                
            case let .categoriesResponse(categories):
                state.isLoading = false
                state.categories = categories
                return .none
                
            case let .didSelectCategory(category):
                state.path.append(.init(category: category))
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            YogaCategoryDetailFeature()
        }
    }
}
