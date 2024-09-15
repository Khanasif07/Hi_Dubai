//
//  CDMovieDataRepository.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//

import Foundation
import CoreData

//https://developer.apple.com/documentation/coredata/synchronizing_a_local_store_to_the_cloud
struct MovieDataRepository : BaseRepository{
    
    typealias T = Movie
    
    func create(record: Movie) {

        let cdMovie = CDMovie(context: PersistentStorage.shared.context)
        cdMovie.id = Int32(record.id)
        cdMovie.title = record.title
        cdMovie.overview = record.overview
        cdMovie.posterPath = record.posterPath
        PersistentStorage.shared.saveContext()

    }

    func getAll() -> [Movie]?
    {
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDMovie.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [Movie] = []
        records!.forEach({ (cdEmployee) in
            results.append(cdEmployee.convertToMovie())
        })

        return results
    }

    func get(byIdentifier id: Int32) -> Movie? {

        let result = self.getCdMovie(byId: Int(id))
        guard result != nil else {return nil}

        return result!.convertToMovie()
    }

    func update(record: Movie) -> Bool {

        let cdEmployee = self.getCdMovie(byId: record.id)
        guard cdEmployee != nil else {return false}

        cdEmployee?.title = record.title
        PersistentStorage.shared.saveContext()

        return true
    }

    func delete(byIdentifier id: Int32) -> Bool
    {
        let employee = getCdMovie(byId: Int(id))
        guard employee != nil else {return false}

        PersistentStorage.shared.context.delete(employee!)
        PersistentStorage.shared.saveContext()

        return true
    }

    private func getCdMovie(byId id: Int) -> CDMovie?
    {
        let fetchRequest = NSFetchRequest<CDMovie>(entityName: "CDMovie")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }


}
