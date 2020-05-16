//
//  MainPresenter.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import CoreData
class MainPresenter: MainPresenterProtocol{
    lazy var presistanceManager = PresistanceManager.instance
    weak var mainView:MainViewProtocol?
    init(mainView:MainViewProtocol,context: NSManagedObjectContext) {
        self.mainView = mainView
        presistanceManager.mainPresenter = self
        presistanceManager.managedContex = context
        
    }
    init() {
        
    }
    
    func getMovies() {
        presistanceManager.getMovies()
    }
    
    func refreshView(movieList: [NSManagedObject]) {
        if let mainView = mainView {
            mainView.refreshViews(moviesList: movieList)
        }
    }
    func deleteMovie(_ movie: NSManagedObject){
        presistanceManager.deleteMovie(movie)
    }
}
