//
//  Quack.swift
//
//  Created by App Dev Academy on 5/14/16.
//  Copyright © 2016 App Dev Academy. All rights reserved.
//

import UIKit

public class Quack {
    
    /**
        Singleton instance
    */
    private static let shared = Quack()
    
    /**
        Lazy initialize hover window and keep strong reference on it
    */
    private lazy var hoverWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.clearColor()
        window.windowLevel = UIWindowLevelStatusBar - 1
        window.screen = UIScreen.mainScreen()
        return window
    }()
    
    /**
        Present UIAlertController with title, message and "OK" button from specified controller
    */
    public class func showAlert(title title: String?, message: String?, inController presentingController: UIViewController) {
        
        // Create alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK button title in alerts"), style: UIAlertActionStyle.Default, handler: nil))
        
        // Present alert
        presentingController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /**
        Present light transparent hover with spinner
    */
    public class func showLightHover() {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .Light)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Present light transparent hover with spinner and text
    */
    public class func showLightHover(text text: String) {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .Light, text: text)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Present dark transparent hover with spinner
    */
    public class func showDarkHover() {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .Dark)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Present light transparent hover with spinner and text
    */
    public class func showDarkHover(text text: String) {
        Quack.shared.hoverWindow.rootViewController = HoverViewController(hoverStyle: .Dark, text: text)
        Quack.shared.hoverWindow.makeKeyAndVisible()
    }
    
    /**
        Instantly hide hover
    */
    public class func hideHover() {
        Quack.shared.hoverWindow.hidden = true
        UIApplication.sharedApplication().delegate?.window??.makeKeyAndVisible()
    }
    
    /**
        Hide hover with animation
    */
    public class func hideHover(animated animated: Bool) {
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
    public func showAlert(title title: String?, message: String?) {
        Quack.showAlert(title: title, message: message, inController: self)
    }
}