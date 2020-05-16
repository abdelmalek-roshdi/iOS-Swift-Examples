//
//  SearchPresenter.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/12/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import CoreData
class SearchPresenter: SearchProtocol {
    lazy var presistanceManager = PresistanceManager.instance
    var searchView:SearchViewProtocol?
    
    func searchMovie(movieName: String) {
        presistanceManager.searchMovie(movieName: movieName)
    }
    
    init(searchView:SearchViewProtocol,context: NSManagedObjectContext) {
         self.searchView = searchView
         presistanceManager.managedContex = context
         
     }
    
     
}
