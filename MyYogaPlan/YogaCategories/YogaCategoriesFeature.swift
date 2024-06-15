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
        var selectedCategory: YogaCategory?
        var isLoading: Bool = false
        var errorMessage: String?
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case fetchCategories
        case categoriesResponse([YogaCategory])
        case selectCategory(YogaCategory)
        case destination(PresentationAction<Destination.Action>)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case categoryDetail(YogaCategoryDetailFeature)
        case alert(AlertState<String>)
    }
    
    @Dependency(\.yogaCategoriesClient) private var yogaCategoriesClient
    @Dependency(\.mainQueue) private var mainQueue
    
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
                
            case let .selectCategory(category):
                state.selectedCategory = category
                state.destination = .categoryDetail(YogaCategoryDetailFeature.State(category: category))
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension AlertState where Action == String {
    static func fetchError(_ message: String) -> Self {
        Self {
            TextState(message)
        } actions: {
            ButtonState(role: .cancel) {
                TextState("OK")
            }
        }
    }
}
