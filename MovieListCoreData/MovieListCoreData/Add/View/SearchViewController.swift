//
//  SearchViewController.swift
//  MovieListCoreData
//
//  Created by Abd-Elmalek on 4/12/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import CoreData
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchViewProtocol {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchPresenter: SearchPresenter?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContex: NSManagedObjectContext?
    var searchresenter:SearchProtocol?

    
    @IBAction func searchAction(_ sender: UIButton) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        managedContex = appDelegate.persistentContainer.viewContext
        searchPresenter = SearchPresenter(searchView: self, context: managedContex!)
        searchMovie(movieName: "toy")
        
    }
    func searchMovie(movieName: String) {
        searchPresenter?.searchMovie(movieName: movieName)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
