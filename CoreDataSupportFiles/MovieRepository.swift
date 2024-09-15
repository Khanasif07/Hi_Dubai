//
//  MovieRepository.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//

import Foundation

protocol MovieBaseRepository {
    func getAnimalRecords(completionHandler:@escaping(_ result: Array<Movie>?)->Void)
}

protocol MovieCoreDataRepository : MovieBaseRepository {
    func insertMovieRecords(records:Array<Movie>) -> Bool
}

protocol MovieApiResourceRepository : MovieBaseRepository {
    
}

protocol MovieRepository {
    func getMovieRecords(completionHandler:@escaping(_ result: Array<Movie>?)->Void)
}
