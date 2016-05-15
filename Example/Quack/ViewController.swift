//
//  ViewController.swift
//  Quack
//
//  Created by Maksym Skliarov on 05/14/2016.
//  Copyright (c) 2016 Maksym Skliarov. All rights reserved.
//

import UIKit
import Quack

class ViewController: UIViewController {
    
    private var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: - Actions
    
    func hideHover() {
        self.timer?.invalidate()
        self.timer = nil
        
        Quack.hideHover()
        // or with animation
        // Quack.hideHover(animated: true)
    }
    
    @IBAction func showAlert() {
        self.showAlert(title: "Alert title", message: "Bigger description of the problem")
        // or from Quack class
        // Quack.showAlert(title: "Alert title", message: "Bigger description of the problem", inController: self)
    }
    
    @IBAction func showHover() {
        
        // Present hover to user
        Quack.showDarkHover(text: "Loading")
        
        // Create timer to hide hover
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.hideHover), userInfo: nil, repeats: false)
    }
}