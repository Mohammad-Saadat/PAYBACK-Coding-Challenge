//
//  UIAlertController.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

extension UIAlertController {
    private static var style: UIStatusBarStyle = .default
    
    func setStyle(style: UIStatusBarStyle) {
        UIAlertController.style = style
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIAlertController.style
    }
}
