//
//  Pumkin.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 20/06/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pumpkin = try? JSONDecoder().decode(Pumpkin.self, from: jsonData)

import Foundation

// MARK: - PumpkinElement
struct Pumpkin: Codable {
    //
    var isSelected: Bool? = false
    //
    let id: Int?
    let name, tagline, firstBrewed, description: String?
    let imageURL: String?
    let abv, ibu: Double?
    let targetFg: Int?
    let targetOg: Double?
    let ebc: Double?
    let srm, ph, attenuationLevel: Double?
    let volume, boilVolume: BoilVolume?
    let method: Method?
    let ingredients: Ingredients?
    let foodPairing: [String]?
    let brewersTips: String?
    let contributedBy: String?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double?
    let unit: Unit?
}

enum Unit: String, Codable {
    case celsius = "celsius"
    case grams = "grams"
    case kilograms = "kilograms"
    case litres = "litres"
}

//enum ContributedBy: String, Codable {
//    case aliSkinnerAliSkinner = "Ali Skinner <AliSkinner>"
//    case samMasonSamjbmason = "Sam Mason <samjbmason>"
//}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]?
    let hops: [Hop]?
    let yeast: String?
}

// MARK: - Hop
struct Hop: Codable {
    let name: String?
    let amount: BoilVolume?
    let add: String?
    let attribute: String?
}

enum Add: String, Codable {
    case dryHop = "dry hop"
    case end = "end"
    case middle = "middle"
    case start = "start"
    case fifteen = "15"
    case zero = "0"
}

enum Attribute: String, Codable {
    case aroma = "aroma"
    case attributeAroma = " aroma"
    case bitter = "bitter"
    case flavour = "flavour"
    case twist = "twist"

}

// MARK: - Malt
struct Malt: Codable {
    let name: String?
    let amount: BoilVolume?
}

// MARK: - Method
struct Method: Codable {
    let mashTemp: [MashTemp]?
    let fermentation: Fermentation?
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume?
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume?
    let duration: Int?
}

typealias Welcome = [Pumpkin]
