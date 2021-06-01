//
//  CALayerExtension.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

extension CALayer {
    func addCornerRadius(_ value: CGFloat) {
        self.masksToBounds = true
        self.cornerRadius = value
    }

    func addBorder(_ width: CGFloat, color: UIColor) {
        self.borderWidth = width
        self.borderColor = color.cgColor
    }
    
    func removeBorder() {
        self.borderWidth = 0.0
    }
   
}
