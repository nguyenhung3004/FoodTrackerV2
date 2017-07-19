//
//  ImageView.swift
//  FoodTracker
//
//  Created by Hung Nguyen on 7/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

@IBDesignable

class ImageView: UIImageView {
    
    @IBInspectable
    var borderWidth: CGFloat = 0{
        didSet {
            self.layer.borderWidth = CGFloat(borderWidth)
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0{
        didSet {
            if cornerRadius == -1{
                self.layer.cornerRadius = self.bounds.width > self.bounds.height ? self.bounds.width * 0.5 : self.bounds.height * 0.5
            }
        }
    }
}
