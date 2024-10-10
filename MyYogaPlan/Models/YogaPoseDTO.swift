//
//  YogaPoseDTO.swift
//  
//
//  Created by Coleton Gorecke on 10/10/24.
//

import Foundation

public struct YogaPoseDTO: Codable {
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
