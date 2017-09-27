//
//  HomeButton.swift
//  Map With Direction
//
//  Created by Mac on 9/22/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation

import Foundation
import UIKit

@IBDesignable class HomeButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        customize()
    }
    
    @IBInspectable var rounded: Bool = true {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        layer.borderColor = UIColor.white.cgColor as CGColor
        layer.borderWidth = 2.0
        
        clipsToBounds = true
    }
    
    func customize() {
        titleLabel?.textAlignment = .center
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.green : UIColor.clear
        }
    }
    
}
