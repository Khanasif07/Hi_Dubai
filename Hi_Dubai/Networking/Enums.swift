//
//  Enums.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
enum EndPoint : String {
    case news        =  "https://api.jsonbin.io/v3/b/635249d865b57a31e69d9143"
    case news_updated  = "https://hidubaifocusapi.free.beeceptor.com/articles"
    case x_master_key = "$2b$10$YyUJiWKHl8CtW90XTkp7ru9ysDiWLhw5AsU4UTSSBgV5AUFPyxDfy"
    case pumpkin     = "https://api.punkapi.com/v2/beers"
}

public enum AppNetworkingHttpMethods: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case patch   = "PATCH"
}

enum ShimmerState {
    case toBeApply // Shimmer will show
    case applied // shimmer applied
    case none // When api failed return 0 in cases
}


enum CustomError: Int, Error{
    case timeOut = -1001
    case otherError = 208
}
