//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Emanuele Cundari on 19/03/16.
//  Copyright © 2016 Emanuele Cundari. All rights reserved.
//

import UIKit


class LoginVC: UIViewController {

    @IBOutlet var emailConstraint: NSLayoutConstraint!
    @IBOutlet var passwordConstraint: NSLayoutConstraint!
    @IBOutlet var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }


}

