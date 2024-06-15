//
//  YogaCategoriesClient.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import Foundation

struct YogaCategoriesClient {
    var fetchCategories: () async throws -> [YogaCategory]
}

extension YogaCategoriesClient: DependencyKey {
    static let liveValue = Self(
        fetchCategories: {
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "https://yoga-api-nzy4.onrender.com/v1/categories")!
            )
            let decoder = JSONDecoder()
            return try decoder.decode([YogaCategory].self, from: data)
        }
    )
}

extension DependencyValues {
    var yogaCategoriesClient: YogaCategoriesClient {
        get { self[YogaCategoriesClient.self] }
        set { self[YogaCategoriesClient.self] = newValue }
    }
}
