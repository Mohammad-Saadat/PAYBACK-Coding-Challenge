//
//  UIWindow+ChangeRoot.swift
//  RTACore
//
//  Created by Mohammad Ali Jafarian on 3/2/18.
//  Copyright © 2018 Behzad Ardehei. All rights reserved.
//
import UIKit

public extension UIWindow {
    /// Changes root view controller with the specified view controller
    /// with desired animation
    ///
    /// - Parameters:
    ///   - viewController: View controller to be set as root view controller
    ///   - animated: _(optional)_ Whether or not to animated the process
    ///   - transitionStyle: _(optional)_ Desired transition style
    func changeRootViewController(to viewController: (UIViewController & RTAChangeRootProtocol),
                                  animated: Bool? = nil,
                                  transitionStyle: RTAChangeRootTransitionStyle? = nil,
                                  duration: Double? = nil) {
        let animated = animated ?? viewController.prefersChangeRootAnimated
        guard animated else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        let transitionStyle = transitionStyle ?? viewController.preferredChangeRootTransitionStyle
        let duration = duration ?? viewController.preferredChangeRootTransitionDuration
        switch transitionStyle {
        case .fromTop:
            changeRootViewControllerFromTop(to: viewController, duration: duration)
        case .fromDown:
            changeRootViewControllerFromDown(to: viewController, duration: duration)
        case .fromRight:
            changeRootViewControllerFromRight(to: viewController, duration: duration)
        case .fromLeft:
            changeRootViewControllerFromLeft(to: viewController, duration: duration)
        case .fadeIn:
            changeRootViewControllerFadeIn(to: viewController, duration: duration)
        case .fadeOut:
            changeRootViewControllerFadeOut(to: viewController, duration: duration)
        case .none:
            changeRootViewControllerNone(to: viewController, duration: duration)
        }
    }
}

private extension UIWindow {
    func changeRootViewControllerPlain(to viewController: UIViewController) {
        rootViewController = viewController
        makeKeyAndVisible()
    }

    func changeRootViewControllerFromTop(to viewController: UIViewController, duration: Double) {
        // take a snap shot of source view controller
        guard let srcSnap = snapshotView(afterScreenUpdates: true) else {
            // do it without animation
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // take snapshot of destination view controller
        guard let dstSnap = snapshotView(afterScreenUpdates: true) else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // move destination snap to top
        dstSnap.frame = CGRect(origin: CGPoint(x: 0, y: dstSnap.bounds.size.height * -1), size: dstSnap.bounds.size)
        viewController.view.addSubview(dstSnap)
        viewController.view.addSubview(srcSnap)
        // move down source snap to hide
        UIView.transition(with: srcSnap, duration: duration, options: .curveEaseInOut, animations: {
            let orginY = UIScreen.main.bounds.maxY
            srcSnap.frame = CGRect(origin: CGPoint(x: 0, y: orginY), size: srcSnap.frame.size)
        }, completion: { _ in
            srcSnap.removeFromSuperview()
        })
        // move down destination snap to show
        UIView.transition(with: dstSnap, duration: duration, options: .curveEaseInOut, animations: {
            dstSnap.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: srcSnap.frame.size)
        }, completion: { _ in
            dstSnap.removeFromSuperview()
        })
    }

    func changeRootViewControllerFromDown(to viewController: UIViewController, duration: Double) {
        // take a snap shot of source view controller
        guard let srcSnap = snapshotView(afterScreenUpdates: true) else {
            // do it without animation
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // take snapshot of destination view controller
        guard let dstSnap = snapshotView(afterScreenUpdates: true) else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // move destination snap to top
        dstSnap.frame = CGRect(origin: CGPoint(x: 0, y: dstSnap.bounds.size.height), size: dstSnap.bounds.size)
        viewController.view.addSubview(dstSnap)
        viewController.view.addSubview(srcSnap)
        // move down source snap to hide
        UIView.transition(with: srcSnap, duration: duration, options: .curveEaseInOut, animations: {
            let orginY = UIScreen.main.bounds.maxY * -1
            srcSnap.frame = CGRect(origin: CGPoint(x: 0, y: orginY), size: srcSnap.frame.size)
        }, completion: { _ in
            srcSnap.removeFromSuperview()
        })
        // move down destination snap to show
        UIView.transition(with: dstSnap, duration: duration, options: .curveEaseInOut, animations: {
            dstSnap.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: srcSnap.frame.size)
        }, completion: { _ in
            dstSnap.removeFromSuperview()
        })
    }

    func changeRootViewControllerFromRight(to viewController: UIViewController, duration: Double) {
        // take a snap shot of source view controller
        guard let srcSnap = snapshotView(afterScreenUpdates: true) else {
            // do it without animation
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // take snapshot of destination view controller
        guard let dstSnap = snapshotView(afterScreenUpdates: true) else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // move destination snap to top
        dstSnap.frame = CGRect(origin: CGPoint(x: dstSnap.bounds.size.width, y: 0), size: dstSnap.bounds.size)
        viewController.view.addSubview(dstSnap)
        viewController.view.addSubview(srcSnap)
        // move down source snap to hide
        UIView.transition(with: srcSnap, duration: duration, options: .curveEaseInOut, animations: {
            let originX = UIScreen.main.bounds.width * -1
            srcSnap.frame = CGRect(origin: CGPoint(x: originX, y: 0), size: srcSnap.frame.size)
        }, completion: { _ in
            srcSnap.removeFromSuperview()
        })
        // move down destination snap to show
        UIView.transition(with: dstSnap, duration: duration, options: .curveEaseInOut, animations: {
            dstSnap.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: srcSnap.frame.size)
        }, completion: { _ in
            dstSnap.removeFromSuperview()
        })
    }

    func changeRootViewControllerFromLeft(to viewController: UIViewController, duration: Double) {
        // take a snap shot of source view controller
        guard let srcSnap = snapshotView(afterScreenUpdates: true) else {
            // do it without animation
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // take snapshot of destination view controller
        guard let dstSnap = snapshotView(afterScreenUpdates: true) else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // move destination snap to top
        dstSnap.frame = CGRect(origin: CGPoint(x: dstSnap.bounds.size.width * -1, y: 0), size: dstSnap.bounds.size)
        viewController.view.addSubview(dstSnap)
        viewController.view.addSubview(srcSnap)
        // move down source snap to hide
        UIView.transition(with: srcSnap, duration: duration, options: .curveEaseInOut, animations: {
            let originX = UIScreen.main.bounds.width
            srcSnap.frame = CGRect(origin: CGPoint(x: originX, y: 0), size: srcSnap.frame.size)
        }, completion: { _ in
            srcSnap.removeFromSuperview()
        })
        // move down destination snap to show
        UIView.transition(with: dstSnap, duration: duration, options: .curveEaseInOut, animations: {
            dstSnap.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: srcSnap.frame.size)
        }, completion: { _ in
            dstSnap.removeFromSuperview()
        })
    }

    func changeRootViewControllerFadeIn(to viewController: UIViewController, duration: Double) {
        // take a snap shot of source view controller
        guard let srcSnap = snapshotView(afterScreenUpdates: true) else {
            // do it without animation
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // take snapshot of destination view controller
        guard let dstSnap = snapshotView(afterScreenUpdates: true) else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        dstSnap.alpha = 0
        viewController.view.addSubview(srcSnap)
        viewController.view.addSubview(dstSnap)
        // move down source snap to hide
        UIView.transition(with: srcSnap, duration: duration, options: .curveEaseInOut, animations: {
            dstSnap.alpha = 1
        }, completion: { _ in
            srcSnap.removeFromSuperview()
            dstSnap.removeFromSuperview()
        })
    }

    func changeRootViewControllerNone(to viewController: UIViewController, duration: Double) {
        // do it without animation
        changeRootViewControllerPlain(to: viewController)
    }

    func changeRootViewControllerFadeOut(to viewController: UIViewController, duration: Double) {
        // take a snap shot of source view controller
        guard let srcSnap = snapshotView(afterScreenUpdates: true) else {
            // do it without animation
            changeRootViewControllerPlain(to: viewController)
            return
        }
        // take snapshot of destination view controller
        guard let dstSnap = snapshotView(afterScreenUpdates: true) else {
            changeRootViewControllerPlain(to: viewController)
            return
        }
        viewController.view.addSubview(dstSnap)
        viewController.view.addSubview(srcSnap)
        // move down source snap to hide
        UIView.transition(with: srcSnap, duration: duration, options: .curveEaseInOut, animations: {
            srcSnap.alpha = 0
        }, completion: { _ in
            srcSnap.removeFromSuperview()
            dstSnap.removeFromSuperview()
        })
    }
}
