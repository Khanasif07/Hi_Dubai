//
//  CDMovie+CoreDataProperties.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var overview: String?

}

extension CDMovie : Identifiable {

}

extension CDMovie{
    func convertToMovie() -> Movie
    {
        return Movie(id: Int(self.id), title: self.title!, posterPath: self.posterPath!, overview: self.overview!)
    }
}
