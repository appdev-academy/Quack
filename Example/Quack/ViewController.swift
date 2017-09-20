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
    
    fileprivate var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @objc func hideHover() {
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
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.hideHover), userInfo: nil, repeats: false)
    }
}
