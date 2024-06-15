//
//  YogaCategoryDetailFeature.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import Foundation

struct YogaPosesClient {
    var fetchPoses: (YogaCategory) async throws -> [YogaPose]
}

extension YogaPosesClient: DependencyKey {
    static let liveValue = Self(
        fetchPoses: { category in
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "https://yoga-api-nzy4.onrender.com/v1/poses?id=\(category.id)")!
            )
            let decoder = JSONDecoder()
            return try decoder.decode([YogaPose].self, from: data)
        }
    )
}

extension DependencyValues {
    var yogaPosesClient: YogaPosesClient {
        get { self[YogaPosesClient.self] }
        set { self[YogaPosesClient.self] = newValue }
    }
}

@Reducer
struct YogaCategoryDetailFeature {
    @ObservableState
    struct State: Equatable {
        var category: YogaCategory
        var poses: [YogaPose] = []
        var isLoading: Bool = false
        var errorMessage: String?
    }
    
    enum Action {
        case fetchPoses
        case posesResponse([YogaPose])
    }
    
    @Dependency(\.yogaPosesClient) private var yogaPosesClient
    @Dependency(\.mainQueue) private var mainQueue
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchPoses:
                state.isLoading = true
                return .run { [category = state.category] send in
                    do {
                        let poses = try await yogaPosesClient.fetchPoses(category)
                        await send(.posesResponse(poses))
                    } catch {
                        print("Failed to fetch poses with error: \(error)")
                        await send(.posesResponse([]))
                    }
                }
                
            case let .posesResponse(poses):
                state.isLoading = false
                state.poses = poses
                return .none
            }
        }
    }
}

import SwiftUI

struct YogaCategoryDetailView: View {
    @Bindable var store: StoreOf<YogaCategoryDetailFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                Section("Description") {
                    Text(store.category.categoryDescription)
                        .font(.body)
                }
            }
            .navigationTitle(store.category.categoryName)
//            .onAppear {
//                store.send(.fetchPoses)
//            }
        }
    }
}
