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
        @Shared(.fileStorage(.documentsDirectory.appending(component: "YogaCategories.json")))
        var categories: [YogaCategory] = []
        var isLoading: Bool = false
        
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
    
    @Dependency(\.yogaCategoriesRemoteStore) private var remoteStore
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCategories:
                if state.categories.isEmpty {
                    state.isLoading = true
                    return .run { send in
                        do {
                            let categories = try await remoteStore.fetchCategories()
                            await send(.categoriesResponse(categories))
                        } catch {
                            print("Failed to fetch categories with error: \(error)")
                            await send(.categoriesResponse([]))
                        }
                    }
                } else {
                    return .send(.categoriesResponse(state.categories))
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
