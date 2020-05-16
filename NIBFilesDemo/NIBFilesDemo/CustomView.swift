//
//  CustomView.swift
//  NIBFilesDemo
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit

class CustomView: UIView {

    @IBOutlet weak var customButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBAction func button(_ sender: Any) {
        print("hello there!")
        label.text = "hiiii!"
    }
   
    
    
    
    
 
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
