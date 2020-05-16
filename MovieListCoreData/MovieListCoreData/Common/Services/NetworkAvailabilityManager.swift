//
//  NetworkAvailabilityManager.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import Network
class NetworkAvailabilitymanager{
   static let instance = NetworkAvailabilitymanager()
   private let monitor = NWPathMonitor()
   private init() {
        
    }
    func isNetworkAvailable() -> Bool {
        var isAvailble = false
        monitor.pathUpdateHandler = { path in
                   if path.status == .satisfied {
                       print("We're connected!")
                        isAvailble = true
                    PresistanceManager.instance.getMovies()
                   } else {
                       print("No connection.")
                       isAvailble = false
                    PresistanceManager.instance.mainPresenter?.refreshView(movieList: PresistanceManager.instance.getOfflineMovies())
                      
                   }
            }
        return isAvailble
    }
    
}
