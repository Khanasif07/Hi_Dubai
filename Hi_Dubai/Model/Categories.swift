//
//  Categories.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/07/2023.
//

// Categories.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

import Foundation

// MARK: - Categories
struct Categories: Codable {
    var postURL: [String]?
    var countries, personalInterests: [BusinessSuggestionKey]?
    var categories: [Category]?
    var neighborhoods: [Neighborhood]?
    var reportTypes: [ReportType]?
    var businessSuggestionKeys: [BusinessSuggestionKey]?
    var userTypes: [UserType]?
    var serpDefaultLocation: SerpDefaultLocation?
    var neighborhoodWithCoordinates: [NeighborhoodWithCoordinate]?

    enum CodingKeys: String, CodingKey {
        case postURL = "postUrl"
        case countries, personalInterests, categories, neighborhoods, reportTypes, businessSuggestionKeys, userTypes, serpDefaultLocation, neighborhoodWithCoordinates
    }
}

// BusinessSuggestionKey.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let businessSuggestionKey = try? newJSONDecoder().decode(BusinessSuggestionKey.self, from: jsonData)

//import Foundation

// MARK: - BusinessSuggestionKey
struct BusinessSuggestionKey: Codable {
    var uuid, code: String?
    var label: Label?
    var links: [Link]?
    var id: String?
}

// Label.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let label = try? newJSONDecoder().decode(Label.self, from: jsonData)

//import Foundation

// MARK: - Label
struct Label: Codable {
    var ar, en: String?
}

// Link.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let link = try? newJSONDecoder().decode(Link.self, from: jsonData)

//import Foundation

// MARK: - Link
struct Link: Codable {
    var rel: Rel?
    var href: String?
}

// Rel.swift

//import Foundation

enum Rel: String, Codable {
    case relSelf = "self"
}

// Category.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try? newJSONDecoder().decode(Category.self, from: jsonData)

//import Foundation

// MARK: - Category
struct Category: Codable {
    var uuid: String?
    var name: Label?
    var type: CategoryType?
    var children: [Child]?
    var classImage: String?
    var position: Int?
    var preferred: Bool?
    var links: [JSONAny]?
    var id: String?
}

// Child.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let child = try? newJSONDecoder().decode(Child.self, from: jsonData)

//import Foundation

// MARK: - Child
struct Child: Codable {
    var uuid: String?
    var name: Description?
    var type: ChildType?
    var masterID, friendlyURLName: String?
    var children: [JSONAny]?
    var classImage: String?
    var preferred: Bool?
    var categoryKeywords: CategoryKeywords?
    var links: [JSONAny]?
    var id: String?
    var description: Description?

    enum CodingKeys: String, CodingKey {
        case uuid, name, type
        case masterID = "masterId"
        case friendlyURLName = "friendlyUrlName"
        case children, classImage, preferred, categoryKeywords, links, id, description
    }
}

// CategoryKeywords.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoryKeywords = try? newJSONDecoder().decode(CategoryKeywords.self, from: jsonData)

//import Foundation

// MARK: - CategoryKeywords
struct CategoryKeywords: Codable {
    var ar: [JSONAny]?
    var en: [String]?
}

// Description.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let description = try? newJSONDecoder().decode(Description.self, from: jsonData)

//import Foundation

// MARK: - Description
struct Description: Codable {
    var en: String?
}

// ChildType.swift

//import Foundation

enum ChildType: String, Codable {
    case macro = "MACRO"
}

// CategoryType.swift

//import Foundation

enum CategoryType: String, Codable {
    case master = "MASTER"
}

// NeighborhoodWithCoordinate.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let neighborhoodWithCoordinate = try? newJSONDecoder().decode(NeighborhoodWithCoordinate.self, from: jsonData)

//import Foundation

// MARK: - NeighborhoodWithCoordinate
struct NeighborhoodWithCoordinate: Codable {
    var name: Label?
    var latitude, longitude: Double?
    var elevation: Int?
    var links: [Link]?
    var id: String?
}

// Neighborhood.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let neighborhood = try? newJSONDecoder().decode(Neighborhood.self, from: jsonData)

//import Foundation

// MARK: - Neighborhood
struct Neighborhood: Codable {
    var uuid: String?
    var createdBy, lastModifiedBy, createdDate, lastModifiedDate: JSONNull?
    var auto, formatted: Label?
    var geo: Geo?
    var links: [Link]?
    var id: String?
}

// Geo.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let geo = try? newJSONDecoder().decode(Geo.self, from: jsonData)

//import Foundation

// MARK: - Geo
struct Geo: Codable {
    var latitude, longitude: Double?
    var elevation: Int?
}

// ReportType.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reportType = try? newJSONDecoder().decode(ReportType.self, from: jsonData)

//import Foundation

// MARK: - ReportType
struct ReportType: Codable {
    var uuid, code, context: String?
    var reportSet: ReportSet?
    var label: Label?
    var links: [Link]?
    var id: String?
}

// ReportSet.swift

//import Foundation

enum ReportSet: String, Codable {
    case report = "REPORT"
    case suggestion = "SUGGESTION"
}

// SerpDefaultLocation.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serpDefaultLocation = try? newJSONDecoder().decode(SerpDefaultLocation.self, from: jsonData)

//import Foundation

// MARK: - SerpDefaultLocation
struct SerpDefaultLocation: Codable {
    var label: Label?
    var latitude, longitude: Double?
}

// UserType.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userType = try? newJSONDecoder().decode(UserType.self, from: jsonData)

//import Foundation

// MARK: - UserType
struct UserType: Codable {
    var uuid, createdBy, lastModifiedBy, createdDate: JSONNull?
    var lastModifiedDate: JSONNull?
    var name: Label?
    var links: [JSONAny]?
    var id: String?
}

// JSONSchemaSupport.swift

//import Foundation

// MARK: - Encode/decode helpers

//@objcMembers class JSONNull: NSObject, Codable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    override public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

@objcMembers class JSONAny: NSObject, Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
