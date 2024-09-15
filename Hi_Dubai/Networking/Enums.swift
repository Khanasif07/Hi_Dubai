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
    case pumpkin      = "https://api.punkapi.com/v2/beers"
    case searchMovie  = "https://api.themoviedb.org/3/search/movie"
    case popularMovie =  "https://api.themoviedb.org/3/movie/popular"
//    case hidubai_categories = "https://vrj7khl603.execute-api.ap-southeast-1.amazonaws.com/qa/config"
    case hidubai_categories = "https://vrj7khl603.execute-api.ap-southeast-1.amazonaws.com/qa/categories/tree"
    
    case movieDetail  = "https://api.themoviedb.org/3/movie/"
    case tmdb_api_key = "020e7b126f0ee278311159ff7dd3028c"
    case tmdb_access_token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMjBlN2IxMjZmMGVlMjc4MzExMTU5ZmY3ZGQzMDI4YyIsInN1YiI6IjY0OTJhNTExNGJhNTIyMDEzOTM4NzA2OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CzMJ5X8uv94mXBcmqh0bQPIXwDcEUOYBC53GNiS2dcw"
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
