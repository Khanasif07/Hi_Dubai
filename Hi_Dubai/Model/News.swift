//
//  News.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation

struct News: Codable {
    let record: [Record]
    let metadata: Metadata
}

// MARK: - Metadat
struct Metadata: Codable {
    let id: String
    let metadatPrivate: Bool
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case metadatPrivate = "private"
        case createdAt
    }
}

// MARK: - Record
struct Record: Codable {
    let title: String
    let postURL: String
    let publishedAt: Date
    let postImageURL: String
    let readTime, primaryTag, content: String
    var dateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: publishedAt)
    }

    enum CodingKeys: String, CodingKey {
        case title
        case postURL = "postUrl"
        case publishedAt
        case postImageURL = "postImageUrl"
        case readTime, primaryTag, content
    }
}

