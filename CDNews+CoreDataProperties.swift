//
//  CDNews+CoreDataProperties.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//
//

import Foundation
import CoreData


extension CDNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNews> {
        return NSFetchRequest<CDNews>(entityName: "CDNews")
    }

    @NSManaged public var title: String?
    @NSManaged public var postURL: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var postImageURL: String?
    @NSManaged public var readTime: String?
    @NSManaged public var primaryTag: String?
    @NSManaged public var content: String?

}

extension CDNews : Identifiable {

}
