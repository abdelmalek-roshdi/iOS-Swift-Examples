//
//  AddViewController.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/26/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var generTextField: UITextField!
    var imagePicker: UIImagePickerController?
    var movie :Movie?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContex: NSManagedObjectContext?
    var movieEntity: NSManagedObject?
    
    @IBOutlet weak var releaseDatePicker: UIDatePicker!
    var firstview: RefreshMoviesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        managedContex = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func addImageFromGalleryAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker?.sourceType = .photoLibrary
            imagePicker?.allowsEditing = true
            if let picker = imagePicker{
                    self.present(picker, animated: true, completion: nil)
            }
        }else{
            print("gallery not available")
        }
    
    }
    
    @IBAction func AddAction(_ sender: UIBarButtonItem) {
       
        
        let title = nameTextField.text ?? "empty title"
        let rating = ratingTextField.text?.floatValue ?? 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: releaseDatePicker.date)
        let rYear = Int(year) ?? 0
        let image = imageUrlTextField.text ?? ""
        let genre = [generTextField.text ?? ""]
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
          
          firstview?.refreshMovies()
          self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            //imageView.image = image
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            let photoURL = URL.init(fileURLWithPath: localPath!)
            print(photoURL)
            movie?.image = photoURL.absoluteString
            print("image location")
            print(movie?.image ?? "default value")
            self.dismiss(animated: true, completion: nil)
            
        }
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
