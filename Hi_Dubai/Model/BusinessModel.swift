//
//  BusinessModel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 13/08/2023.
//

import Foundation


// MARK: - Welcome
struct BusinessModel: Codable {
    let data: [Business]
}

// MARK: - Datum
struct Business: Codable {
    let localBusinessSeq: Int
    let businessName: BusinessName
    let id, friendlyURL: String
    let thumbnailURL: String
    let plainNeighborhood: PlainNeighborhood

    enum CodingKeys: String, CodingKey {
        case localBusinessSeq, businessName, id
        case friendlyURL = "friendlyUrl"
        case thumbnailURL = "thumbnailUrl"
        case plainNeighborhood
    }
}

// MARK: - BusinessName
struct BusinessName: Codable {
    let ar: String?
    let en: String
}

// MARK: - PlainNeighborhood
struct PlainNeighborhood: Codable {
    let id: String
    let name: Name
    let district: BusinessName
}

// MARK: - Name
struct Name: Codable {
    let en: String
}
