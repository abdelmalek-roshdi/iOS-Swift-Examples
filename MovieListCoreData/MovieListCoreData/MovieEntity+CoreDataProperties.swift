//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by Abd-Elmalek on 4/1/20.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var genre: [String]?
    @NSManaged public var image: String?
    @NSManaged public var rating: Float
    @NSManaged public var releaseYear: Int16
    @NSManaged public var title: String?

}
