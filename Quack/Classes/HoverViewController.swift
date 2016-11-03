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
        case light
        case dark
    }
    
    // MARK: - User interface elements
    
    /**
        Spinner in the center
    */
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    /**
        UILabel under spinner
    */
    fileprivate let titleLabel = UILabel(frame: CGRect.zero)
    /**
        Duration of show/hide animation
    */
    fileprivate var animationDuration: TimeInterval = 0.25
    /**
        HoverStyle for this view controller
    */
    fileprivate var hoverStyle = HoverStyle.dark
    /**
        Text that will be shown under the spinner
    */
    fileprivate var text = ""
    
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
        
        self.view.backgroundColor = .clear
        
        self.addSpinner()
        self.addLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateShow()
    }
    
    fileprivate func addSpinner() {
        if self.hoverStyle == .light {
            self.activityIndicatorView.activityIndicatorViewStyle = .gray
        } else {
            self.activityIndicatorView.activityIndicatorViewStyle = .white
        }
        self.activityIndicatorView.alpha = 0.0
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(
            item: self.activityIndicatorView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.activityIndicatorView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        )
        self.view.addConstraints(constraints)
    }
    
    fileprivate func addLabel() {
        if self.hoverStyle == .light {
            self.titleLabel.textColor = .black
        } else {
            self.titleLabel.textColor = .white
        }
        self.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.titleLabel.alpha = 0.0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = self.text
        self.titleLabel.numberOfLines = 1
        self.view.addSubview(self.titleLabel)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.activityIndicatorView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 22.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1.0,
            constant: 20.0)
        )
        constraints.append(NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .trailing,
            multiplier: 1.0,
            constant: -20.0)
        )
        self.view.addConstraints(constraints)
    }
    
    /**
        Animate presentation of HoverViewController
    */
    fileprivate func animateShow() {
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.activityIndicatorView.alpha = 1.0
            self.titleLabel.alpha = 0.6
            if self.hoverStyle == .light {
                self.view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
            } else {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            }
        }) 
    }
    
    /**
        Animate hide of HoverViewController
    */
    internal func animateHide() {
        UIView.animate(
            withDuration: self.animationDuration,
            animations: {
                
                self.activityIndicatorView.alpha = 0.0
                self.titleLabel.alpha = 0.0
                self.view.backgroundColor = .clear
                
            }, completion: {
                finished in
                
                Quack.hideHover()
            }
        )
    }
}
