//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Emanuele Cundari on 19/03/16.
//  Copyright © 2016 Emanuele Cundari. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width,
            CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    let ANIM_DELAY: Int = 1
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int) {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
            if (index > 0) {
                moveAnim.dynamicsFriction += 15 + CGFloat(index)
                }
            
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
                
            } while (index < self.constraints.count)
            
        }
        
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation!, Bool) -> Void)) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 8
        moveAnim.springSpeed = 8
        moveAnim.completionBlock = completion
        view.pop_addAnimation(moveAnim, forKey: "moveToPosition")
    }
    
    class func changeLbl(label: UILabel) {
        let redColor = UIColor.redColor()
        let animation = POPSpringAnimation(propertyNamed: kPOPLabelTextColor)
        animation.toValue = redColor
        animation.springBounciness = 1
        animation.springSpeed = 8
        label.pop_addAnimation(animation, forKey: "changeColor")
        
        
        func scaleToSmall() {
            let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
            scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.85, 0.85))
            label.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
        }
        
        func scaleAnimation() {
            let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            scaleAnim.velocity = NSValue(CGSize: CGSizeMake(10.0, 10.0))
            scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.2, 1.2))
            scaleAnim.springBounciness = 28
            label.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
        }
        
        func scaleToDefault() {
            let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
            scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
            label.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleDefaultAnimation")
        }
        
        scaleAnimation()
        scaleToSmall()
        scaleToDefault()
        
    }
    
    
}


























