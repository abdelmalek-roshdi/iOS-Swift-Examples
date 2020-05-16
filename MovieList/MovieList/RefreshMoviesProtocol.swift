//
//  RefreshMoviesProtocol.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/26/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
protocol RefreshMoviesProtocol {
    var movieList: [Movie] {get set}
    func refreshMovies();
}
