//
//  AddViewController.swift
//  MovieList
//
//  Created by Abd-Elmalek on 3/26/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var generTextField: UITextField!
    var imagePicker: UIImagePickerController?
    var movie :Movie?
    
    @IBOutlet weak var releaseDatePicker: UIDatePicker!
    var firstview: RefreshMoviesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        movie = Movie()
        // Do any additional setup after loading the view.
        
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
       
        
        movie!.title = nameTextField.text ?? "empty title"
        movie!.rating = ratingTextField.text?.floatValue ?? 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: releaseDatePicker.date)
        movie!.realseYear = Int(year) ?? 1900
        //movie!.image = imageUrlTextField.text?.description ?? ""
        movie!.gener = [generTextField.text ?? ""]
        DBHelper.instance.insertMovie(movie: movie!)
        print("movie -----")
        print(movie!.id)
        firstview?.movieList.append(movie!)
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
            print(movie?.image)
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
