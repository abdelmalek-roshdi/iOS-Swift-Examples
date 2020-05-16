//
//  SearchProtocol.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/12/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation

import CoreData
protocol SearchProtocol: AnyObject {
    func searchMovie(movieName: String)
}

