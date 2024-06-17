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
    
    // MARK: - Helpers
    private func buildMockData(of count: Int) -> [YogaCategory] {
        var array: [YogaCategory] = []
        for i in 1...count {
            array.append(
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
        return array
    }
    
    // MARK: - Tests
    func testFetchCategories() async throws {
        let mockData = buildMockData(of: 2)
        store = TestStore(initialState: YogaCategoriesFeature.State()) {
            YogaCategoriesFeature()
        } withDependencies: {
            $0.yogaCategoriesRemoteStore = YogaCategoriesRemoteStore(fetchCategories: {
                return mockData
            })
        }
        
        await store.send(.fetchCategories) {
            $0.isLoading = false
            $0.isLoading = true
        }
        
        await store.receive(\.categoriesResponse, timeout: 1) {
            $0.isLoading = false
            $0.categories = mockData
        }
    }
    
    func testDidSelectCategory() async throws {
        let mockData = buildMockData(of: 2)
        
        store = TestStore(initialState: YogaCategoriesFeature.State()) {
            YogaCategoriesFeature()
        } withDependencies: {
            $0.yogaCategoriesRemoteStore = YogaCategoriesRemoteStore(fetchCategories: {
                return mockData
            })
        }
        
        let selectedCategory = mockData.first!
        
        await store.send(.didSelectCategory(selectedCategory)) {
            $0.path.append(.init(category: selectedCategory))
        }
    }
    
    func testFetchCategories_Failure_ReturnsEmpty() async throws {
        store = TestStore(initialState: YogaCategoriesFeature.State()) {
            YogaCategoriesFeature()
        } withDependencies: {
            $0.yogaCategoriesRemoteStore = YogaCategoriesRemoteStore(fetchCategories: {
                throw MockError.expected
            })
        }
        
        await store.send(.fetchCategories) {
            $0.isLoading = false
            $0.isLoading = true
        }
        
        // On error categories should be empty.
        await store.receive(\.categoriesResponse, timeout: 1) {
            $0.isLoading = false
            $0.categories = []
        }
    }
    
    func testFetchCategoriesFromState() async throws {
        let mockData = buildMockData(of: 2)
        let initialState = YogaCategoriesFeature.State(categories: mockData)
        store = TestStore(initialState: YogaCategoriesFeature.State()) {
            YogaCategoriesFeature()
        } withDependencies: {
            $0.yogaCategoriesRemoteStore = YogaCategoriesRemoteStore(fetchCategories: {
                return mockData
            })
        }
        
        await store.send(.fetchCategories)
        
        // assert we recieve a response
        await store.receive(\.categoriesResponse, timeout: 1)
    }
    
}

enum MockError: Error {
    case expected
    case unexpected
}
