//
//  BaseRepository.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//

import Foundation

protocol BaseRepository {

    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: Int32) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: Int32) -> Bool
}
