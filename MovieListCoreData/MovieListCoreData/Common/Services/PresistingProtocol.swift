//
//  PresistingProtocol.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import CoreData
protocol PresistingProtocol {
    func getMovies()
    func getOfflineMoviesAPI(_ entity:String) -> [NSManagedObject]
    func getOfflineMoviesUserDefined(_ entity:String) -> [NSManagedObject]
    func getOfflineMovies() -> [NSManagedObject]
    func deleteAllMoviesAPIData(entityName: String)
    func deleteMovie(_ movie: NSManagedObject)
}
