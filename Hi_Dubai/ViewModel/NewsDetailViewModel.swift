//
//  NewsDetailViewModel.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
class NewsDetailViewModel{
    var newsModel: NewsModel?
    var movie    : MovieDetail?
    func getCellViewModel() -> NewsModel?{
        return newsModel
    }
}
