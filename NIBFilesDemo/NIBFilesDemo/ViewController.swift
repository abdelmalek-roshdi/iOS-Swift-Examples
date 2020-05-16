//
//  ViewController.swift
//  NIBFilesDemo
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let customView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
        
        customView.frame = CGRect(x: 10, y: 10, width: self.view.frame.width, height: self.view.frame.height*0.3)
        
        self.view.addSubview(customView);
    }


}

