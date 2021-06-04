//
//  KeyboardHandlerDelegate.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation

@objc public protocol KeyboardHandlerDelegate: class {
    
    /// Asks delegate whether to handle KeyboardWillShow
    /// notification or not
    ///
    /// - Parameters:
    ///   - keyboardHandler: This instance of keyboard handler
    ///   - keyboardInfo: Information of keyboard
    /// - Returns: Whether to handle KeyboardWillShow or not
    @objc optional func keyboardHandler(_ keyboardHandler: KeyboardHandler, shouldHandleKeyboardWillShowWithInfo keyboardInfo: KeyboardInfo) -> Bool
    
    /// Asks delegate whether to handle KeyboardDidShow
    /// notification or not
    ///
    /// - Parameters:
    ///   - keyboardHandler: This instance of keyboard handler
    ///   - keyboardInfo: Information of keyboard
    /// - Returns: Whether to handle KeyboardDidShow or not
    @objc optional func keyboardHandler(_ keyboardHandler: KeyboardHandler, shouldHandleKeyboardDidShowWithInfo keyboardInfo: KeyboardInfo) -> Bool
    
    /// Asks delegate whether to handle KeyboardWillHide
    /// notification or not
    ///
    /// - Parameters:
    ///   - keyboardHandler: This instance of keyboard handler
    ///   - keyboardInfo: Information of keyboard
    /// - Returns: Whether to handle KeyboardWillHide or not
    @objc optional func keyboardHandler(_ keyboardHandler: KeyboardHandler, shouldHandleKeyboardWillHideWithInfo keyboardInfo: KeyboardInfo) -> Bool
    
    /// Asks delegate whether to handle KeyboardDidHide
    /// notification or not
    ///
    /// - Parameters:
    ///   - keyboardHandler: This instance of keyboard handler
    ///   - keyboardInfo: Information of keyboard
    /// - Returns: Whether to handle KeyboardDidHide or not
    @objc optional func keyboardHandler(_ keyboardHandler: KeyboardHandler, shouldHandleKeyboardDidHideWithInfo keyboardInfo: KeyboardInfo) -> Bool
}
