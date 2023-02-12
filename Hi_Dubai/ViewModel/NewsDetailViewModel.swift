//
//  NewsDetailViewModel.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
class NewsDetailViewModel{
    var newsModel: Record?
    func getCellViewModel() -> Record?{
        return newsModel
    }
}
