//
//  YogaCategoriesRemoteStore.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import MyYogaCore
import Foundation

protocol YogaCategoriesRemoteStore {
    func fetchCategories() async throws -> [YogaCategoryDTO]
}

final class YogaCategoriesRemoteRepo: YogaCategoriesRemoteStore {
    // MARK: - Dependencies
    private let api: YogaAPI
    
    init(
        api: YogaAPI = YogaAPIClient.shared
    ) {
        self.api = api
    }
    
    // MARK: - Interface
    func fetchCategories() async throws -> [YogaCategoryDTO] {
        do {
            return try await api.fetchCategories()
        } catch {
            print("Failed to fetch categories with error: \(error)")
            throw error
        }
    }
}
