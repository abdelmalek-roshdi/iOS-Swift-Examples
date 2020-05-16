//
//  NextViewController.swift
//  NIBFilesDemo
//
//  Created by Abd-Elmalek on 4/8/20.
//  Copyright © 2020 Abd-Elmalek. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let customView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
                
               customView.frame = CGRect(x: 10, y: 200, width: self.view.frame.width, height: self.view.frame.height*0.3)
        customView.customButton.addTarget(self, action: #selector(self.shayHello), for: .touchUpInside)
               
               self.view.addSubview(customView);
    }
    
    @objc func shayHello(){
        print("saddasdadsasdas")
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
