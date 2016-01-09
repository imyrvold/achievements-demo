//
//  GradientView.swift
//  Achievements
//
//  Created by Ivan C Myrvold on 23.12.2015.
//  Copyright © 2015 Ivan C Myrvold. All rights reserved.
//

import UIKit

class GradientView: UIView {
        
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    func gradientWithColors(firstColor : UIColor, _ secondColor : UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [ firstColor.CGColor, secondColor.CGColor ]
        
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
}


