//
//  RefreshMoviesProtocol.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/26/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import CoreData
protocol RefreshMoviesProtocol {
    var movieList: [NSManagedObject] {get set}
    func refreshMovies();
}
