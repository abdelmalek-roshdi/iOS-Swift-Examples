//
//  ViewController.swift
//  CollectionViewWithImagesDemo
//
//  Created by Abd-Elmalek on 3/29/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
    
//        let url = URL(string: "https://images-na.ssl-images-amazon.com/images/I/5191u1Xie6L._SX303_BO1,204,203,200_.jpg")
//        cell.customImage.kf.setImage(with: url)
//        let cellWidth = UIScreen.main.bounds.width / 2 - 5
//        let cellHight = UIScreen.main.bounds.height / 2 - 5
//        cell.customImage.sizeThatFits(CGSize(width: cellWidth, height: cellHight))
        var url = URL(string:"")
        switch indexPath.item {
    
            case 0:
                url = URL(string: "https://pngimage.net/wp-content/uploads/2018/05/courses-png-6.png")
            case 1:
                url = URL(string: "https://leisure.union.ufl.edu/Content/Images/leisure-courses.png")
            case 2:
                url = URL(string: "https://cdn2.iconfinder.com/data/icons/new-year-resolutions/64/resolutions-06-512.png")
            case 3:
                url = URL(string: "https://pngimage.net/wp-content/uploads/2018/05/courses-png.png")
            case 4:
                url = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-engagement-offering-business.png")
            case 5:
                url = URL(string: "https://feedbacksystems.com/wp-content/uploads/2019/12/Business.png")

        
            default:
                break
        }
        let processor = DownsamplingImageProcessor(size: cell.customImage.image?.size ?? CGSize(width: 100,height: 100))
            |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.customImage.kf.indicatorType = .activity
        cell.customImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder.jpg"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("selected item at row \(indexPath.row) and section \(indexPath.section)")
        print("selected item \(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let cellWidth = UIScreen.main.bounds.width / 2 - 5
             let cellHight = UIScreen.main.bounds.height / 4 - 5
           return CGSize(width: cellWidth, height: cellHight)
       }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if let flowlayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                   let cellWidth = UIScreen.main.bounds.width / 2 - 5
//                   let cellHight = UIScreen.main.bounds.height / 4 - 5
//                   flowlayout.itemSize = CGSize(width: cellWidth, height: cellHight)
//               }
    }


}

