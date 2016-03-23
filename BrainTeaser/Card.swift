//
//  Card.swift
//  BrainTeaser
//
//  Created by Emanuele Cundari on 21/03/16.
//  Copyright © 2016 Emanuele Cundari. All rights reserved.
//

import UIKit

class Card: UIView {

    let shapes = ["shape1", "shape2", "shape3", "shape4", "shape5", "shape6", "shape7"]
    let answerType = ["correct", "incorrect"]
    
    var currentShape: String!
    var currentAnswer: UIImage!
    
    @IBOutlet weak var shapeImage: UIImageView!
    @IBOutlet weak var answerImage: UIImageView!
    
    var animationEngine: AnimationEngine!

    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        selectShape()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.setNeedsLayout()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(7))]
        shapeImage.image = UIImage(named: currentShape)
    }
    
    func setAnswerType(type: String) {
        if type == "correct" {
            answerImage.image = UIImage(named: type)
        } else {
            answerImage.image = UIImage(named: type)
        }
    }
    
}
