//
//  KeyboardInfo.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import UIKit

@objc public class KeyboardInfo: NSObject {
    // ==================
    // MARK: - Properties
    // ==================
    
    /// Frame for begin state of keyboard
    let frameBegin: CGRect
    
    /// Frame for end state of keyboard
    let frameEnd: CGRect
    
    /// Identifies the duration of the animation in seconds
    let animationDuration: TimeInterval
    
    /// defines how the keyboard will be animated onto or off the screen
    let animationOptions: UIView.AnimationOptions
    
    /// Identifies whether the keyboard belongs to the current app
    let isLocal: Bool
    
    // ====================
    // MARK: - Initializers
    // ====================
    init(frameBegin: CGRect, frameEnd: CGRect, animationDuration: TimeInterval, animationOptions: UIView.AnimationOptions, isLocal: Bool) {
        self.frameBegin = frameBegin
        self.frameEnd = frameEnd
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
        self.isLocal = isLocal
    }
    
    convenience init?(userInfo: [AnyHashable: Any]?) {
        guard let userInfo = userInfo else {
            fatalError("Could not find any keyboard notification user info")
        }
        
        guard let frameBegin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else {
            fatalError("Could not find keyboard frame begin")
        }
        
        guard let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            fatalError("Could not find keyboard frame end")
        }
        
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            fatalError("Could not find keyboard animation duration")
        }
        
        guard let animationCurveRawValue = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            fatalError("Could not find keyboard animation curve")
        }
        
        guard let isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool else {
            fatalError("Could not find keyboard is local")
        }
        
        self.init(
            frameBegin: frameBegin,
            frameEnd: frameEnd,
            animationDuration: animationDuration,
            animationOptions: UIView.AnimationOptions(rawValue: animationCurveRawValue),
            isLocal: isLocal
        )
    }
}
