//
//  PresistanceManager.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Alamofire
class PresistanceManager: PresistingProtocol {
    var mainPresenter:MainPresenterProtocol?
    var managedContex: NSManagedObjectContext?
    static let instance = PresistanceManager()
    private init() {
        self.managedContex = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.mainPresenter = MainPresenter()
    }
    func getMovies(){
        
      //  if(NetworkAvailabilitymanager.instance.isNetworkAvailable()){
            let url = URL(string: "https://api.androidhive.info/json/movies.json")
            let request = URLRequest(url: url!)
            let session = URLSession(configuration: .default)
            self.deleteAllMoviesAPIData(entityName: "MovieEntity")
            _ = session.dataTask(with: request) { (data, response, error) in
                do{
                    let jsonArray = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Dictionary<String,Any>>
                    for movieObj in jsonArray{
                        let title: String = movieObj["title"] as! String
                        let image: String = movieObj["image"] as! String
                        let nRating = movieObj["rating"]  as? NSNumber
                        let rating: Float = nRating?.floatValue ?? 0.0
                        let nReleaseYear = movieObj["releaseYear"]  as? NSNumber
                        let releaseYear: Int = nReleaseYear?.intValue ?? 0
                        let gener: [String] = movieObj["genre"] as! [String]
                        DispatchQueue.main.async {
                             if let mContext = self.managedContex{
                               
                                let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: mContext)
                               
                                   print(title)
                                   movieEntity.setValue(title, forKey: "title")
                                   movieEntity.setValue(image, forKey: "image")
                                   movieEntity.setValue(rating, forKey: "rating")
                                   movieEntity.setValue(releaseYear, forKey: "releaseYear")
                                   movieEntity.setValue(gener, forKey: "genre")
                               
                             
                           }
                        }
                    
                    }
                    DispatchQueue.main.async {
                        if let mContext = self.managedContex{
                            do{
                                try mContext.save()
                                //self.getOfflineMovies()
                                if let mainPresenter = self.mainPresenter{
                                    mainPresenter.refreshView(movieList: self.getOfflineMovies())
                                }
                            }catch let error as NSError {
                                print(error.debugDescription)
                            }
                        }
                     //   self.table.reloadData()
                      //  if let ind = self.indicator{
                        //    ind.stopAnimating()
                       // }
                    }
                }catch{
                    print("error fetching data")
                }
                
            }.resume()
            
       // }
//        else {
//
//            if let mianPresenter = self.mainPresenter {
//                 mianPresenter.refreshView(movieList: getOfflineMovies())
//            }
//        }
        
        
    }
    
    func getOfflineMoviesAPI(_ entity:String) -> [NSManagedObject] {
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            
             do {
                 if let mContext = managedContex{
                     let results = try mContext.fetch(fetchRequest) as? [NSManagedObject]
                     if let movieListOffline = results {
                     return  movieListOffline
                         
                     }
                 }
             } catch let error {
                 print("get all data in MovieEntity error :", error)
             }
        return [NSManagedObject]()
    }
    
    func getOfflineMoviesUserDefined(_ entity:String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                   
                    do {
                        if let mContext = managedContex{
                            let results = try mContext.fetch(fetchRequest) as? [NSManagedObject]
                            if let movieListOffline = results {
                            return  movieListOffline
                                
                            }
                        }
                    } catch let error {
                        print("Detele all data in MovieEnitityOffline error :", error)
                    }
               return [NSManagedObject]()
    }
    
    func getOfflineMovies() -> [NSManagedObject] {
        return getOfflineMoviesAPI("MovieEntity") + getOfflineMoviesUserDefined("MovieEnitityOffline")
    }
    
    func deleteAllMoviesAPIData(entityName: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            if let mContext = managedContex{
                let results = try mContext.fetch(fetchRequest)
                for object in results {
                    guard let objectData = object as? NSManagedObject else {continue}
                    mContext.delete(objectData)
                }
            }
        } catch let error {
            print("Detele all data in \(entityName) error :", error)
        }
    }
    
    func deleteMovie(_ movie: NSManagedObject) {
           do {
               if let mContext = managedContex{
                       mContext.delete(movie)
                try mContext.save()
                   
               }
           } catch let error {
               print("error :", error)
           }
       }
    
    func searchMovie(movieName: String) {
        AF.request("http://api.themoviedb.org/3/search/movie?api_key=9ba2a10e20c15ef6fb276c33692ba9e8&query=\(movieName)").response { response in
            
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: response.data!, options: []) as! Dictionary<String,Any>
                let jsonArray = jsonDictionary["results"] as! Array<Dictionary<String,Any>>
                
                   for movieObj in jsonArray{
                             let title: String = movieObj["original_title"] as! String
                             let image: String = movieObj["poster_path"] as? String ?? ""
                             let nRating = movieObj["vote_average"]  as? NSNumber
                             let rating: Float = nRating?.floatValue ?? 0.0 // /2
                            let nReleaseYear = (movieObj["release_date"]  as? String)?.prefix(4)
                           let s = String(nReleaseYear!)
                            let releaseYear: Int = Int(s) ?? 0
                             let gener: [IntegerLiteralType] = movieObj["genre_ids"] as! [IntegerLiteralType]
                            
                          print(releaseYear.description)
                         
                         }
                
            }
            catch let error as NSError {
                print(error.debugDescription)
            }
            //debugPrint(response)
        }
    }
    
    
    
}
