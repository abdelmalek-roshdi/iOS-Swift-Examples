//
//  AddTableViewController.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/2/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import CoreData
class AddTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var releaseYearTextField: UITextField!
    @IBOutlet weak var genreTexField: UITextField!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContex: NSManagedObjectContext?
    var movieEntity: NSManagedObject?
    var firstview: RefreshMoviesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContex = appDelegate.persistentContainer.viewContext
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addAction(_ sender: UIButton) {
        
            
                
                let title = nameTextField.text ?? "empty title"
                let rating = ratingTextField.text?.floatValue ?? 1
                let rYear = Int(releaseYearTextField.text!) ?? 0
                let image = imageTextField.text ?? ""
                let genre = [genreTexField.text ?? ""]
                if let mContext = self.managedContex{
                
                    movieEntity = NSEntityDescription.insertNewObject(forEntityName: "MovieEnitityOffline", into: mContext)
                    if let movieEntity = movieEntity {
                        movieEntity.setValue(title, forKey: "title")
                        movieEntity.setValue(image, forKey: "image")
                        movieEntity.setValue(rating, forKey: "rating")
                        movieEntity.setValue(rYear, forKey: "releaseYear")
                        movieEntity.setValue(genre, forKey: "genre")
                    }
                    
                    do{
                        firstview?.movieList.append(movieEntity!)
                        print("appended")
                        try mContext.save()
                        print("saved")
                          
                        }catch let error as NSError {
                            print("error inserting ")
                          print(error.debugDescription)
                    }
                    
              
                  }
        //        DBHelper.instance.insertMovie(movie: movie!)
        //        print("movie -----")
        //        print(movie!.id)
                  
                  firstview?.refreshMovies()
                  self.navigationController?.popViewController(animated: true)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
