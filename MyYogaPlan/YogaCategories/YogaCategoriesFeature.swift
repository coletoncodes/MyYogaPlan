//
//  YogaCategoriesFeature.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SelectCategoryFeature {
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

@Reducer
struct YogaCategoriesFeature {
    @ObservableState
    struct State: Equatable {
        var categories: [YogaCategory] = []
        var isLoading: Bool = false
        var errorMessage: String?
        
        var path = StackState<SelectCategoryFeature.State>()
    }
    
    enum Action {
        case fetchCategories
        case categoriesResponse([YogaCategory])
        case didSelectCategory(YogaCategory)
        case path(StackAction<SelectCategoryFeature.State, SelectCategoryFeature.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case selectCategory(SelectCategoryFeature)
    }
    
    @Dependency(\.yogaCategoriesClient) private var yogaCategoriesClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCategories:
                state.isLoading = true
                return .run { send in
                    do {
                        let categories = try await yogaCategoriesClient.fetchCategories()
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
            SelectCategoryFeature()
        }
    }
}
