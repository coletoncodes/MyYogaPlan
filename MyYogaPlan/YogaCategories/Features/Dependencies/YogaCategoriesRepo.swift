//
//  YogaCategoriesRepo.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import Foundation
import MyYogaCore

struct YogaCategoriesRepo {
    var localCategories: [YogaCategory]
    var fetchCategories: () async throws -> [YogaCategory]
}

extension YogaCategoriesRepo: DependencyKey {
    
    static var liveValue: YogaCategoriesRepo {
        let localStore = FilePersistenceManager<[YogaCategoryDTO]>(subdirectory: "YogaCategories")
        let remoteStore = YogaCategoriesRemoteRepo()
        
        let localData = localStore.data
        
        return Self(
            localCategories: localData?.map(\.asYogaCategory) ?? [],
            fetchCategories: {
                if let localData { return localData.map(\.asYogaCategory) }
                let remoteDTOS = try await remoteStore.fetchCategories()
                localStore.save(remoteDTOS)
                return remoteDTOS.map(\.asYogaCategory)
            }
        )
    }
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
            benefits: benefits,
            isFavorite: false
        )
    }
}

extension DependencyValues {
    var yogaCategoriesRepo: YogaCategoriesRepo {
        get { self[YogaCategoriesRepo.self] }
        set { self[YogaCategoriesRepo.self] = newValue }
    }
}
