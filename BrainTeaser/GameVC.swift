//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Emanuele Cundari on 19/03/16.
//  Copyright © 2016 Emanuele Cundari. All rights reserved.
//

import UIKit
import pop
import AudioToolbox
import AVFoundation

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    var timer = NSTimer()
    var seconds = 60
    
    var correct = 0
    var incorrect = 0
    var cardCounter = -1
    
    var currentCard: Card!
    var previousCard: Card!
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        previousCard = currentCard
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(GameVC.stopTimer), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(GameVC.startTimer), name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }
    
    func countDown() {
        seconds -= 1
        timerLbl.text = "00:\(seconds)"
        
        if seconds < 10 {
            AnimationEngine.changeLbl(timerLbl)
        }
        if seconds == 0 {
            timer.invalidate()
            seconds = 0
            showResults()
        }
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameVC.countDown), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "START" {
            startTimer()
        }
        
        if sender.titleLabel?.text == "YES" {
            checkYesAnswer()
        } else {
            titleLbl.text = "Does this card match the previus?"
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: UIButton) {
        checkNoAnswer()
        showNextCard()
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            
            previousCard = cardToRemove
            
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            cardCounter += 1
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
            }
            
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
            })
            
            
        }
        
    }
    
        func createCardFromNib() -> Card! {
            return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
        
    }
    
    func checkYesAnswer() {
        if currentCard.currentShape == previousCard.currentShape {
            correctChoice()
        } else {
            incorrectChoice()
        }
    }
    
    func checkNoAnswer() {
        if currentCard.currentShape != previousCard.currentShape {
            correctChoice()
        } else {
            incorrectChoice()
        }
    }
    
    func correctChoice() {
        correct += 1
        currentCard.setAnswerType("correct")
        let audioFilePath = NSBundle.mainBundle().pathForResource("correct", ofType: "mp3")
        
        if audioFilePath != nil {
            let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: audioFileUrl)
                audioPlayer.play()
            } catch {
                AudioServicesPlaySystemSound(SystemSoundID(1111))
            }
        } else {
            AudioServicesPlaySystemSound(SystemSoundID(1111))
        }
        
    }
    
    func incorrectChoice() {
        incorrect += 1
        currentCard.setAnswerType("incorrect")
        
        let audioFilePath = NSBundle.mainBundle().pathForResource("incorrect", ofType: "wav")
        
        if audioFilePath != nil {
            let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            
            do {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                audioPlayer = try AVAudioPlayer(contentsOfURL: audioFileUrl)
                audioPlayer.play()
            } catch {
                AudioServicesPlaySystemSound(SystemSoundID(1073))
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        } else {
            AudioServicesPlaySystemSound(SystemSoundID(1073))
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    func showResults() {
        timerLbl.hidden = true
        performSegueWithIdentifier("results", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? ResultsVC {
            destination.correctReceiver = correct
            destination.incorrectReceiver = incorrect
            destination.cardCounterReceiver = cardCounter
        }
    }
    
    

}



























