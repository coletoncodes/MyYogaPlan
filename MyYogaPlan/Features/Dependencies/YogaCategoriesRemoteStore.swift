//
//  YogaCategoriesRemoteStore.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import Foundation

struct YogaCategoriesRemoteStore {
    var fetchCategories: () async throws -> [YogaCategory]
}

extension YogaCategoriesRemoteStore: DependencyKey {
    
    static let liveValue = YogaCategoriesRemoteStore(
            fetchCategories: {
                let (data, _) = try await URLSession.shared.data(
                    from: URL(string: "https://yoga-api-nzy4.onrender.com/v1/categories")!
                )
                let decoder = JSONDecoder()
                return try decoder.decode([YogaCategoryDTO].self, from: data).map(\.asYogaCategory)
            }
        )
}

extension YogaCategoryDTO {
    var asYogaCategory: YogaCategory {
        YogaCategory(
            id: self.id,
            name: self.categoryName,
            description: self.categoryDescription,
            poses: self.poses.map(\.asYogaPose)
        )
    }
}

extension YogaPoseDTO {
    var asYogaPose: YogaPose {
        let benefits = self.poseBenefits
            .components(separatedBy: ".")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        return YogaPose(
            id: self.id,
            name: self.englishName,
            description: self.poseDescription,
            urlPNG: self.urlPNG,
            benefits: benefits
        )
    }
}

extension DependencyValues {
    var yogaCategoriesRemoteStore: YogaCategoriesRemoteStore {
        get { self[YogaCategoriesRemoteStore.self] }
        set { self[YogaCategoriesRemoteStore.self] = newValue }
    }
}
