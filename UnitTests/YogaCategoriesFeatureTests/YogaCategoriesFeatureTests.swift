//
//  YogaCategoriesFeatureTests.swift
//  MyYogaPlanTests
//
//  Created by Coleton Gorecke on 6/15/24.
//

@testable import MyYogaPlan
import ComposableArchitecture
import XCTest

@MainActor
final class YogaCategoriesFeatureTests: XCTestCase {
    private var store: TestStore<YogaCategoriesFeature.State, YogaCategoriesFeature.Action>!
    
    private var mockData: [YogaCategory] = []
    
    override func setUp() {
        super.setUp()
        
        let mockRemoteStore = YogaCategoriesRemoteStore {
            return self.mockData
        }
        
        store = TestStore(
            initialState: YogaCategoriesFeature.State()
        ) {
            YogaCategoriesFeature()
        } withDependencies: {
            $0.yogaCategoriesRemoteStore = mockRemoteStore
        }
    }
    
    // MARK: - Helpers
    private func buildMockData(of count: Int) {
        for i in 1...count {
            self.mockData.append(
                .init(
                    id: i,
                    name: "Mock \(i)",
                    description: "Description \(i)",
                    poses: [
                        .init(id: i, name: "Mock Pose \(i)", description: "Mock Description \(i)", urlPNG: "", benefits: [])
                    ]
                )
            )
        }
    }
    
    // MARK: - Tests
    func testFetchCategories() async throws {
        buildMockData(of: 2)
        await store.send(.fetchCategories) {
            $0.isLoading = false
            $0.errorMessage = nil
            $0.isLoading = true
        }
        
        await store.receive(\.categoriesResponse, timeout: 1) {
            $0.isLoading = false
            $0.categories = self.mockData
        }
    }
    
    func testDidSelectCategory() async throws {
        buildMockData(of: 2)
        let selectedCategory = self.mockData.first!
        
        await store.send(.didSelectCategory(selectedCategory)) {
            $0.path.append(.init(category: selectedCategory))
        }
    }
}
