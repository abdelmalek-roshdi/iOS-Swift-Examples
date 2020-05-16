//
//  DetailsViewController.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/25/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController {
    var movie : NSManagedObject?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genersLabel: UILabel!
  
    @IBOutlet weak var reLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = movie?.value(forKey: "title") as? String ?? ""
        ratingLabel.text = (movie?.value(forKey: "rating") as? Float ?? 0.0).description
        reLabel.text = (movie?.value(forKey: "releaseYear") as? Int16 ?? 0).description
        movieImage?.load.request(with: movie?.value(forKey: "image") as? String ?? "" )
        genersLabel.text = (movie?.value(forKey: "genre") as? [String] ?? [String]()).description
        
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
