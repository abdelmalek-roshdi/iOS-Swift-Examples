//
//  CustomCollectionViewCell.swift
//  RxSwiftDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var codeLabel: UILabel!
    var country:Country?{
        
        didSet{
            nameLabel.text = country?.name
            codeLabel.text = country?.code
        }
    }
   
    
    
}
