//
//  FavoritePosesFeatureTests.swift
//  UnitTests
//
//  Created by Coleton Gorecke on 6/16/24.
//

@testable import MyYogaPlan
import ComposableArchitecture
import XCTest

extension YogaPose {
    static func mockData(of count: Int) -> Set<YogaPose> {
        var set = Set<YogaPose>()
        for i in 1...count {
            set.insert(
                .init(
                    id: i,
                    name: "Mock Pose \(i)",
                    description: "Mock Description \(i)",
                    urlPNG: "",
                    benefits: []
                )
            )
        }
        return set
    }
}

@MainActor
final class FavoritePosesFeatureTests: XCTestCase {
    private var store: TestStore<FavoritePosesFeature.State, FavoritePosesFeature.Action>!
    
    // MARK: - Tests
    func testLoadFavoritesNoFavorites() async throws {
        let mockData = Set<YogaPose>()
        store = TestStore(initialState: FavoritePosesFeature.State(favoritePoses: mockData)) {
            FavoritePosesFeature()
        }
        
        await store.send(.loadFavorites) {
            $0.shouldShowFavorites = false
        }
        
        await store.receive(.favoritesLoaded(mockData), timeout: 1)
    }
    
    func testLoadFavoritesWithFavorites() async throws {
        let mockData: Set<YogaPose> = Set(YogaPose.mockData(of: 10))
        store = TestStore(initialState: FavoritePosesFeature.State(favoritePoses: mockData)) {
            FavoritePosesFeature()
        }
        
        await store.send(.loadFavorites)
        
        await store.receive(.favoritesLoaded(mockData)) {
            $0.shouldShowFavorites = true
            $0.favoritePoses = mockData
        }
    }
    
    func testDidFavoritePoseRemovesPose() async throws {
        let mockData: Set<YogaPose> = Set(YogaPose.mockData(of: 10))
        let poseToRemove = mockData.first!
        store = TestStore(initialState: FavoritePosesFeature.State(favoritePoses: mockData)) {
            FavoritePosesFeature()
        }
        
        await store.send(.didFavoritePose(poseToRemove)) {
            $0.shouldShowFavorites = false
            var updatedPoseToRemove = poseToRemove
            updatedPoseToRemove.isFavorite = false
            $0.favoritePoses.remove(updatedPoseToRemove)
        }
        
        await store.receive(.favoritesLoaded(store.state.favoritePoses)) {
            $0.favoritePoses = self.store.state.favoritePoses
            $0.shouldShowFavorites = !$0.favoritePoses.isEmpty
        }
    }
    
    func testDidFavoritePoseAddsPose() async throws {
        let mockData: Set<YogaPose> = Set(YogaPose.mockData(of: 10))
        let poseToAdd = YogaPose(id: 11, name: "New Pose", description: "A new yoga pose", urlPNG: "", benefits: [])
        store = TestStore(initialState: FavoritePosesFeature.State(favoritePoses: mockData)) {
            FavoritePosesFeature()
        }
        
        await store.send(.didFavoritePose(poseToAdd)) {
            $0.shouldShowFavorites = false
            var updatedPoseToAdd = poseToAdd
            updatedPoseToAdd.isFavorite = true
            $0.favoritePoses.insert(updatedPoseToAdd)
        }
        
        await store.receive(.favoritesLoaded(store.state.favoritePoses)) {
            $0.favoritePoses = self.store.state.favoritePoses
            $0.shouldShowFavorites = !$0.favoritePoses.isEmpty
        }
    }
}
