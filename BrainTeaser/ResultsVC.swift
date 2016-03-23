//
//  ResultsVC.swift
//  BrainTeaser
//
//  Created by Emanuele Cundari on 23/03/16.
//  Copyright © 2016 Emanuele Cundari. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    @IBOutlet var correctLbl: UILabel!
    @IBOutlet var incorrectLbl: UILabel!
    @IBOutlet var totalLbl: UILabel!
    
    
    // constraits
    @IBOutlet var correctConstraint: NSLayoutConstraint!
    @IBOutlet var incorrectConstraint: NSLayoutConstraint!
    @IBOutlet var lineConstraint: NSLayoutConstraint!
    @IBOutlet var totalConstraint: NSLayoutConstraint!
    @IBOutlet var correctResultConstraint: NSLayoutConstraint!
    @IBOutlet var incorrectResultConstraint: NSLayoutConstraint!
    @IBOutlet var totalResultConstraint: NSLayoutConstraint!
    
    
    var animationEngine: AnimationEngine!
    
    var correctReceiver = 0
    var incorrectReceiver = 0
    var cardCounterReceiver = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctLbl.text = "\(correctReceiver)"
        incorrectLbl.text = "\(incorrectReceiver)"
        totalLbl.text = "\(cardCounterReceiver)"
        
        animationEngine = AnimationEngine(constraints: [correctConstraint, incorrectConstraint, lineConstraint, totalConstraint, correctResultConstraint, incorrectResultConstraint, totalResultConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        animationEngine.animateOnScreen(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
