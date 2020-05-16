//
//  Movie.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/25/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
class Movie {
    
    var title: String
    var image: String
    var rating: Float
    var realseYear: Int
    var gener: [String]
   
    
    init(title: String, image: String, rating: Float, realseYear: Int, gener : [String]) {
       
        self.title = title
        self.image = image
        self.rating = rating
        self.realseYear = realseYear
        self.gener = gener
    }
   
    
    
}
