//
//  ViewController.swift
//  MovieListNetworking
//
//  Created by Abd-Elmalek on 3/31/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import Network
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshMoviesProtocol, MainViewProtocol{
   
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let aVC: AddTableViewController = (self.storyboard?.instantiateViewController(identifier: "addTable_viewController"))!
        aVC.firstview = self

        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    
    var indicator: UIActivityIndicatorView?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContex: NSManagedObjectContext?
    var mainPresenter:MainPresenter?
    
    @IBOutlet weak var table: UITableView!
    var movieList: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        managedContex = appDelegate.persistentContainer.viewContext
        mainPresenter = MainPresenter(mainView: self, context: managedContex!)
        mainPresenter!.getMovies()

          indicator = UIActivityIndicatorView(style: .large)
          indicator?.center = self.view.center
          indicator?.startAnimating()
          if let ind = indicator{
             self.view.addSubview(ind)
          }



    }
    
    func refreshMovies() {
        table.reloadData()
    }
    
    func refreshViews(moviesList: [NSManagedObject]) {
        self.movieList = moviesList
        self.table.reloadData()
        if let ind = self.indicator{
               ind.stopAnimating()
           }
       }
    


  //"https://m.media-amazon.com/images/M/MV5BMjA1OTUzNTQ5Ml5BMl5BanBnXkFtZTgwODQ4NDkxNjE@._V1_SY1000_CR0,0,640,1000_AL_.jpg"
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if let index = self.selectedRowIndex{
//            self.tableView.visibleCells
//        }
//        for cell in self.tableView.visibleCells {
//            cell.setSelected(false, animated: true)
//        }
        print(movieList.last?.value(forKey: "title") as? String ?? "not there")
        if let index = self.table.indexPathForSelectedRow{
            self.table.deselectRow(at: index, animated: true)
        }
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.mainPresenter?.deleteMovie(movieList[indexPath.row])
            self.movieList.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        let movie = movieList[indexPath.row]
        cell.leftLabel?.text = movie.value(forKey: "title") as? String ?? ""
        cell.rightLabel?.text = String(movie.value(forKey: "rating") as? Float ?? 0.0)
        cell.customImage?.load.request(with: movie.value(forKey: "image") as? String ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dVC: DetailsViewController = (self.storyboard?.instantiateViewController(identifier: "detail_viewController"))!
        dVC.movie = movieList[indexPath.row]
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
        
    }

}

