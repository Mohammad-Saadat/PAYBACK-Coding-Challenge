//
//  UIViewExtention.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(withDuration duration: TimeInterval = 1.0, complition: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
            complition?()
        }
    }
    
    func fadeOut(withDuration duration: TimeInterval = 1.0, complition: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
            complition?()
        }
    }
        
    func shake(count: Float? = 7, for duration: TimeInterval? = 0.5, withTranslation translation: Float? = nil) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -10
        layer.add(animation, forKey: "shake")
    }
    
    func circle() {
        self.clipsToBounds = true
        self.layer.addCornerRadius(self.frame.width/2)
    }
    
    func addCornerRadius(_ radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.addCornerRadius(radius)
    }
    
    func roundCornerRadiusToMaskCorners(radius: CGFloat, corners: CACornerMask) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func addDashedBorder(color: UIColor, lineWidth: CGFloat = 0.5, lineDashPattern: [NSNumber] = [2, 2]) {
        DispatchQueue.main.async {
            let layer = CAShapeLayer()
            layer.name = "DashedBorder"
            layer.strokeColor = color.cgColor
            layer.lineDashPattern = lineDashPattern
            layer.lineWidth = lineWidth
            layer.lineJoin = .round
            layer.frame = self.bounds
            layer.fillColor = nil
            if self.layer.cornerRadius == 0 {
                layer.path = UIBezierPath(rect: self.bounds).cgPath
            } else {
                layer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            }
            layer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            self.layer.addSublayer(layer)
        }
    }
    
    func removeDashedBorder() {
        for layer in self.layer.sublayers ?? [CALayer]() where layer.name == "DashedBorder" {
            layer.removeFromSuperlayer()
        }
    }
    
    @discardableResult
    func roundCorners(corners: UIRectCorner, radius: CGFloat) -> CALayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        return layer
    }
    
    func fromNib<T: UIView>() -> T {
        guard let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T else { fatalError() }
        return view
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addShadow(shadowRadius: CGFloat = 10.0, opacity: CGFloat = 0.4, color: UIColor = .black, offset: CGSize = CGSize(width: 4, height: 4)) {
           layer.masksToBounds = false
           layer.shadowOffset = offset
           layer.shadowColor = color.cgColor
           layer.shadowRadius = shadowRadius
           layer.shadowOpacity = Float(opacity)
           
           let backgroundCGColor = backgroundColor?.cgColor
           backgroundColor = nil
           layer.backgroundColor =  backgroundCGColor
       }
    
    func rotate(angle: Double = Double.pi * 2, repeatCount: Float = 1, duration: TimeInterval) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: angle)
        rotation.duration = duration
        rotation.repeatCount = repeatCount
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    public func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, trailingConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top: top, leading: leading, bottom: bottom, trailing: trailing, topConstant: topConstant, leadingConstant: leadingConstant, bottomConstant: bottomConstant, trailingConstant: trailingConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, trailingConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}
extension UIView: NibLoadableView {}
