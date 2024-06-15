//
//  YogaPose.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation

struct YogaPose: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let categoryName, englishName, sanskritNameAdapted, sanskritName: String
    let translationName, poseDescription, poseBenefits: String
    let urlSVG: String
    let urlPNG: String
    let urlSVGAlt: String
    
    var benefitsList: [String] {
        self.poseBenefits
            .components(separatedBy: ".")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
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
