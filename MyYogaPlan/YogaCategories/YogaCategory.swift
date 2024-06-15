//
//  YogaCategory.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import Foundation

struct YogaCategory: Identifiable, Codable, Equatable {
    let id: Int
    let categoryName, categoryDescription: String
    let poses: [YogaPose]

    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case categoryDescription = "category_description"
        case poses
    }
}

// MARK: - Pose
struct YogaPose: Identifiable, Codable, Equatable {
    let id: Int
    let categoryName, englishName, sanskritNameAdapted, sanskritName: String
    let translationName, poseDescription, poseBenefits: String
    let urlSVG: String
    let urlPNG: String
    let urlSVGAlt: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case englishName = "english_name"
        case sanskritNameAdapted = "sanskrit_name_adapted"
        case sanskritName = "sanskrit_name"
        case translationName = "translation_name"
        case poseDescription = "pose_description"
        case poseBenefits = "pose_benefits"
        case urlSVG = "url_svg"
        case urlPNG = "url_png"
        case urlSVGAlt = "url_svg_alt"
    }
}
