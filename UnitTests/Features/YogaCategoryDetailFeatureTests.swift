//
//  YogaCategoryDetailFeatureTests.swift
//  UnitTests
//
//  Created by Coleton Gorecke on 6/16/24.
//

@testable import MyYogaPlan
import ComposableArchitecture
import XCTest

@MainActor
final class YogaCategoryDetailFeatureTests: XCTestCase {
    private var store: TestStore<YogaCategoryDetailFeature.State, YogaCategoryDetailFeature.Action>!
    
    // MARK: - Tests
    func testLoadPoses() async throws {
        let mockCategory = YogaCategory.buildMockData(of: 1).first!
        store = TestStore(initialState: YogaCategoryDetailFeature.State(category: mockCategory)) {
            YogaCategoryDetailFeature()
        }
        
        await store.send(.loadPoses) {
            $0.poses = mockCategory.poses
        }
    }
    
    func testDidFavoritePose() async throws {
        let mockCategory = YogaCategory.buildMockData(of: 1).first!
        let favoritePose = mockCategory.poses.first!
        store = TestStore(initialState: YogaCategoryDetailFeature.State(
            category: mockCategory,
            favoritePosesState: .init(favoritePoses: Set())
        )) {
            YogaCategoryDetailFeature()
        }
        
        await store.send(.didFavoritePose(favoritePose)) {
            var newFavoritePose = favoritePose
            newFavoritePose.isFavorite = true
            $0.favoritePosesState.favoritePoses.insert(newFavoritePose)
        }
        
        await store.receive(.favoritePosesAction(.didFavoritePose(favoritePose)))
        
        await store.receive(.loadPoses) {
            $0.poses = Array($0.favoritePosesState.favoritePoses)
        }
    }
    
    func testFavoritePosesAction() async throws {
        let mockCategory = YogaCategory.buildMockData(of: 1).first!
        let favoritePose = mockCategory.poses.first!
        
        store = TestStore(
            initialState: YogaCategoryDetailFeature.State(
                category: mockCategory,
                favoritePosesState: .init(favoritePoses: Set())
            )
        ) {
            YogaCategoryDetailFeature()
        }
        
        await store.send(.favoritePosesAction(.didFavoritePose(favoritePose))) {
            var newFavoritePose = favoritePose
            newFavoritePose.isFavorite = true
            $0.favoritePosesState.favoritePoses.insert(newFavoritePose)
        }
        
        await store.receive(.loadPoses) {
            $0.poses = Array($0.favoritePosesState.favoritePoses)
        }
    }
    
    func testPosesUpdated() async throws {
        let mockCategory = YogaCategory.buildMockData(of: 1).first!
        let updatedPoses = [
            YogaPose(id: 1, name: "Pose 1", description: "Description 1", urlPNG: "", benefits: []),
            YogaPose(id: 2, name: "Pose 2", description: "Description 2", urlPNG: "", benefits: [])
        ]
        
        store = TestStore(
            initialState: YogaCategoryDetailFeature.State(
                category: mockCategory,
                favoritePosesState: .init(favoritePoses: Set())
            )
        ) {
            YogaCategoryDetailFeature()
        }
        
        await store.send(.posesUpdated(updatedPoses)) {
            $0.poses = updatedPoses
        }
    }
}
