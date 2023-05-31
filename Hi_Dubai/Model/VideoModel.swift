//
//  VideoModel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 31/05/2023.
//

import Foundation

struct Video: Codable, Identifiable {
  let id: String
  let name: String
  let headline: String
  
  // Computed Property
  var thumbnail: String {
    "video-\(id)"
  }
}
