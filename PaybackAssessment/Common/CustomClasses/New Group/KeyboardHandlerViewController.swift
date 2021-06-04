//
//  KeyboardHandlerViewController.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import UIKit

class KeyboardHandlerViewController: UIViewController {
    // ==================
    // MARK: - Properties
    // ==================
    var bottomMarginViewController: CGFloat { return 0.0 }
    
    // MARK: Private
    /// Tap gesture recognizer to use for keyboard dismissing
    private lazy var keyboardTapGestureRecognizer: UITapGestureRecognizer = {
        let tempTapGesture = UITapGestureRecognizer(target: UIApplication.shared.keyWindow,
                                                    action: #selector(UIApplication.shared.keyWindow?.endEditing(_:)))
        tempTapGesture.cancelsTouchesInView = false
        tempTapGesture.delegate = self
        return tempTapGesture
    }()
    
    /// Whether notifications are observed or not
    private var areNotificationsObserved = false
    
    // MARK: Public
    var acceptKeyboardNotifications = true
    var hideKeyboardOnViewTapped = true
    var isShowKeyboard = false
    var keyboardHandlerAnimationDuration: TimeInterval?
    
    func willShowCompletion(result: Bool) {
//        print("KeyboardHandler => willShowCompletion")
        self.isShowKeyboard = true
    }
    
    func willHideCompletion(result: Bool) {
//        print("KeyboardHandler => willHideCompletion")
        self.isShowKeyboard = false
    }
    
    deinit {
        removeNotifications()
    }
    
    @objc func handleNotifications(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        //        userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] = 20.0
        
        guard let keyboardInfo = KeyboardInfo(userInfo: userInfo) else { return }
        self.keyboardHandlerAnimationDuration = keyboardInfo.animationDuration
        
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            UIView.animate(withDuration: keyboardInfo.animationDuration,
                           delay: 0.0,
                           options: keyboardInfo.animationOptions,
                           animations: {
                            self.additionalSafeAreaInsets.bottom = keyboardInfo.frameEnd.height - self.bottomMarginViewController -  (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
                            self.view.layoutSubviews()
                           }, completion: {self.willShowCompletion(result: $0)})
        case UIResponder.keyboardWillHideNotification:
            UIView.animate(withDuration: keyboardInfo.animationDuration,
                           delay: 0.0,
                           options: keyboardInfo.animationOptions,
                           animations: {
                            self.additionalSafeAreaInsets.bottom = 0
                            self.view.layoutSubviews()
                           }, completion: {self.willHideCompletion(result: $0)})
        default:
            break
        }
    }
}

// MARK: Life Cycle
extension KeyboardHandlerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        observeNotifications()
        addViewGesture()
    }
}

// ===============
// MARK: - Methods
// ===============

// MARK: Private
private extension KeyboardHandlerViewController {
    func addViewGesture() {
        // Add tap gesture recognizer
        
        guard hideKeyboardOnViewTapped else { return }
        self.view.addGestureRecognizer(keyboardTapGestureRecognizer)
    }
    
    func observeNotifications() {
        guard !areNotificationsObserved, acceptKeyboardNotifications else { return }
        
        [ UIResponder.keyboardWillShowNotification,
          UIResponder.keyboardWillHideNotification]
            .forEach { NotificationCenter.default.addObserver(self, selector: #selector(handleNotifications(_:)), name: $0, object: nil) }
        areNotificationsObserved = true
    }
    
    func removeNotifications() {
        [ UIResponder.keyboardWillShowNotification,
          UIResponder.keyboardWillHideNotification]
            .forEach { NotificationCenter.default.removeObserver(self, name: $0, object: nil) }
    }
}

// ===================================
// MARK: - Gesture Recognizer Delegate
// ===================================
extension KeyboardHandlerViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIControl {
            return false
        }
        return true
    }
}
