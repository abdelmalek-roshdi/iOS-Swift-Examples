//
//  DBHelper.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/30/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper
{
   static let instance = DBHelper()
    
   private init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "moviesDB.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS moviesDB(Id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,image TEXT ,rating REAL ,realseYear INTEGER ,gener TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("moviesDB table created.")
            } else {
                print("moviesDB table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insertMovie(movie: Movie){
        
        let insertStatementString = "INSERT INTO moviesDB (title, image,rating,realseYear,gener) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            //sqlite3_bind_int(insertStatement, 1, Int32(movie.id))
            sqlite3_bind_text(insertStatement, 1, (movie.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (movie.image as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 3, Double(movie.rating))
            sqlite3_bind_int(insertStatement, 4, Int32(movie.realseYear))
            sqlite3_bind_text(insertStatement, 5, (movie.gener.first!  as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                movie.id = Int(sqlite3_last_insert_rowid(db))
               
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        //return movie
        
    }
    
    func getAllMovies() -> [Movie] {
        let queryStatementString = "SELECT * FROM moviesDB;"
        var queryStatement: OpaquePointer? = nil
        var movies : [Movie] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let image = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let rating = sqlite3_column_double(queryStatement, 3)
                let releaseYear = sqlite3_column_int(queryStatement, 4)
                let gener = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let mGener: [String] = [gener]
                movies.append(Movie(id: Int(id), title: title, image: image, rating: Float(rating), realseYear: Int(releaseYear), gener: mGener))
                print("Query Result:")
                print("\(id) | \(title) | \(image)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return movies
    }
    
    func deleteMovieById(id:Int) {
        let deleteStatementStirng = "DELETE FROM moviesDB WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row id = \(id)")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
