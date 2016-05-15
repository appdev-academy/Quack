//
//  HoverViewController.swift
//  Quack
//
//  Created by Maksym Skliarov on 5/15/16.
//
//

import UIKit

/**
    UIViewController used as root view controller of the hover window
*/
internal class HoverViewController: UIViewController {
    
    /**
        Defines style of hover - light or dark
    */
    internal enum HoverStyle {
        case Light
        case Dark
    }
    
    // MARK: - User interface elements
    
    /**
        Spinner in the center
    */
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    /**
        UILabel under spinner
    */
    private let titleLabel = UILabel(frame: CGRect.zero)
    /**
        Duration of show/hide animation
    */
    private var animationDuration: NSTimeInterval = 0.25
    /**
        HoverStyle for this view controller
    */
    private var hoverStyle = HoverStyle.Dark
    /**
        Text that will be shown under the spinner
    */
    private var text = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
        Initialize HoverViewController with HoverStyle
    */
    init(hoverStyle: HoverStyle) {
        super.init(nibName: nil, bundle: nil)
        
        self.hoverStyle = hoverStyle
    }
    
    /**
        Initialize HoverViewController with HoverStyle and text to show
    */
    init(hoverStyle: HoverStyle, text: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.hoverStyle = hoverStyle
        self.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        self.addSpinner()
        self.addLabel()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateShow()
    }
    
    private func addSpinner() {
        if self.hoverStyle == .Light {
            self.activityIndicatorView.activityIndicatorViewStyle = .Gray
        } else {
            self.activityIndicatorView.activityIndicatorViewStyle = .White
        }
        self.activityIndicatorView.alpha = 0.0
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(
            item: self.activityIndicatorView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.activityIndicatorView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0)
        )
        self.view.addConstraints(constraints)
    }
    
    private func addLabel() {
        if self.hoverStyle == .Light {
            self.titleLabel.textColor = UIColor.blackColor()
        } else {
            self.titleLabel.textColor = UIColor.whiteColor()
        }
        self.titleLabel.font = UIFont.systemFontOfSize(12.0)
        self.titleLabel.alpha = 0.0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = .Center
        self.titleLabel.text = self.text
        self.titleLabel.numberOfLines = 1
        self.view.addSubview(self.titleLabel)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.activityIndicatorView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 10.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 22.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 20.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: -20.0)
        )
        self.view.addConstraints(constraints)
    }
    
    /**
        Animate presentation of HoverViewController
    */
    private func animateShow() {
        UIView.animateWithDuration(self.animationDuration) {
            self.activityIndicatorView.alpha = 1.0
            self.titleLabel.alpha = 0.6
            if self.hoverStyle == .Light {
                self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            } else {
                self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
            }
        }
    }
    
    /**
        Animate hide of HoverViewController
    */
    internal func animateHide() {
        UIView.animateWithDuration(
            self.animationDuration,
            animations: {
                
                self.activityIndicatorView.alpha = 0.0
                self.titleLabel.alpha = 0.0
                self.view.backgroundColor = UIColor.clearColor()
                
            }, completion: {
                finished in
                
                Quack.hideHover()
            }
        )
    }
}