//
//  MainViewProtocol.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import CoreData
protocol MainViewProtocol: AnyObject {
    func refreshViews(moviesList: [NSManagedObject])
}
