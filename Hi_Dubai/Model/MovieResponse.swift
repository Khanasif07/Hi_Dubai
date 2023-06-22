//
//  MovieResponse.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 23/06/2023.
//

import Foundation
import UIKit

public struct MoviesResponse: Codable {
    public let page: Int?
    public let totalResults: Int?
    public let totalPages: Int?
    public var results: [Movie]
}

public struct Movie {
    //
    var isSelected: Bool? = false
    //
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    
    public var downloadedImages: UIImage?
    public var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
}

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
    }
}

public struct MovieGenre: Codable {
    let name: String
}

public struct MovieVideoResponse: Codable {
    public let results: [MovieVideo]
}

public struct MovieVideo: Codable {
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}

public struct MovieCreditResponse: Codable {
    public let cast: [MovieCast]
    public let crew: [MovieCrew]
}

public struct MovieCast: Codable {
    public let character: String
    public let name: String
}

public struct MovieCrew: Codable {
    public let id: Int
    public let department: String
    public let job: String
    public let name: String
}
