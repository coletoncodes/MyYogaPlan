//
//  AppFeatureTests.swift
//  UnitTests
//
//  Created by Coleton Gorecke on 6/16/24.
//

@testable import MyYogaPlan
import ComposableArchitecture
import XCTest

@MainActor
final class AppFeatureTests: XCTestCase {
    private var store: TestStore<AppFeature.State, AppFeature.Action>!

    // MARK: - Tests
    func testYogaCategoriesFeature() async throws {
        store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        // Assuming YogaCategoriesFeature.Action has a loadCategories action
        await store.send(.tab1(.categoriesResponse([]))) {
            $0.tab1.categories = []
        }
    }

    func testFavoritePosesFeature() async throws {
        let mockData: Set<YogaPose> = Set(YogaPose.mockData(of: 10))
        store = TestStore(initialState: AppFeature.State(
            tab2: FavoritePosesFeature.State(favoritePoses: mockData)
        )) {
            AppFeature()
        }
        
        let poseToRemove = mockData.first!
        await store.send(.tab2(.didFavoritePose(poseToRemove))) {
            let updatedPoseToRemove = poseToRemove
            $0.tab2.favoritePoses.remove(updatedPoseToRemove)
        }
        
        await store.receive(.tab2(.favoritesLoaded(store.state.tab2.favoritePoses))) {
            $0.tab2.favoritePoses = self.store.state.tab2.favoritePoses
            $0.tab2.shouldShowFavorites = !$0.tab2.favoritePoses.isEmpty
        }
    }
}
