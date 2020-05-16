//
//  ViewController.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/25/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshMoviesProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    var movieList: [Movie] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        let movie = movieList[indexPath.row]
        cell.leftLabel?.text = movie.title
        cell.rightLabel?.text = String(movie.rating)
        cell.customImage?.load.request(with: movie.image)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dVC: DetailsViewController = (self.storyboard?.instantiateViewController(identifier: "detail_viewController"))!
        dVC.movie = movieList[indexPath.row]
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieList = DBHelper.instance.getAllMovies()
        print(movieList)
//        let movie1 = Movie()
//        let movie2 = Movie()
//        let movie3 = Movie()
//        movie1.title = "Gone With The Wind"
//        movie1.rating = 4.3
//        movie1.image = "https://images-na.ssl-images-amazon.com/images/I/5191u1Xie6L._SX303_BO1,204,203,200_.jpg"
//        movie1.realseYear = 1990
//        movie1.gener = ["drama"]
//
//        movie2.title = "Goosebumps"
//        movie2.rating = 4.5
//        movie2.image = "https://m.media-amazon.com/images/M/MV5BMjA1OTUzNTQ5Ml5BMl5BanBnXkFtZTgwODQ4NDkxNjE@._V1_SY1000_CR0,0,640,1000_AL_.jpg"
//        movie2.realseYear = 1998
//        movie2.gener = ["action","thriller"]
//
//
//        movie3.title = "Schindler's List"
//        movie3.rating = 4.6
//        movie3.image = "https://www.filmink.com.au/wp-content/uploads/2019/01/maxresdefault.jpg"
//        movie3.realseYear = 1993
//        movie3.gener = ["drama","thriller"]
//        movieList.append(movie1)
//        movieList.append(movie2)
//        movieList.append(movie3)
//        print(movieList)
    }
    override func viewWillAppear(_ animated: Bool) {
        print(movieList)
    }
    
    func refreshMovies() {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController: AddViewController
        
        addViewController = segue.destination as! AddViewController
        addViewController.firstview = self
    }
}

