//
//  Quack.swift
//
//  Created by App Dev Academy on 5/14/16.
//  Copyright © 2016 App Dev Academy. All rights reserved.
//

import UIKit

open class Quack {
    
    /**
        Singleton instance
    */
    fileprivate static let shared = Quack()
    
    /**
        Lazy initialize hover window and keep strong reference on it
    */
    fileprivate lazy var hoverWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelStatusBar - 1
        window.screen = UIScreen.main
        return window
    }()
    
    /**
        Present UIAlertController with title, message and "OK" button from specified controller
    */
    open class func showAlert(title: String?, message: String?, inController presentingController: UIViewController) {
        
        // Create alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK button title in alerts"), style: .default, handler: nil))
        
        // Present alert
        presentingController.present(alertController, animated: true, completion: nil)
    }
    
    /**
        Present light transparent hover with spinner
    */
    open class func showLightHover() {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .light)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Present light transparent hover with spinner and text
    */
    open class func showLightHover(text: String) {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .light, text: text)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Present dark transparent hover with spinner
    */
    open class func showDarkHover() {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .dark)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Present light transparent hover with spinner and text
    */
    open class func showDarkHover(text: String) {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .dark, text: text)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Instantly hide hover
    */
    open class func hideHover() {
        Quack.shared.hoverWindow.isHidden = true
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
    }
    
    /**
        Hide hover with animation
    */
    open class func hideHover(animated: Bool) {
        if animated {
            if let hoverViewController = Quack.shared.hoverWindow.rootViewController as? HoverViewController {
                hoverViewController.animateHide()
                return
            }
        }
        self.hideHover()
    }
}

public extension UIViewController {
    
    /**
        Present UIAlertController with title, message and "OK" button from current controller
    */
    public func showAlert(title: String?, message: String?) {
        Quack.showAlert(title: title, message: message, inController: self)
    }
}
