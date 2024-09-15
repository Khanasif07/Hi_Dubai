//
//  NewsRepository.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//

import Foundation

protocol NewsBaseRepository {
    func getNewsRecords(completionHandler:@escaping(_ result: Array<NewsModel>?)->Void)
}

protocol NewsCoreDataRepository : NewsBaseRepository {
    func insertNewsRecords(records:Array<NewsModel>) -> Bool
}

protocol NewsApiResourceRepository : NewsBaseRepository {
    
}

protocol NewsRepository {
    func getNewsRecords(completionHandler:@escaping(_ result: Array<NewsModel>?)->Void)
}
