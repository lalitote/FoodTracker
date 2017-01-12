//
//  RatingControl.swift
//  FoodTracker
//
//  Created by lalitote on 15.08.2016.
//  Copyright © 2016 lalitote. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properities
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5

    // MARK: Initialization
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTaped(_:)), for: .touchDown)
            ratingButtons += [button]
            
            addSubview(button)
        }

    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        //let buttonSize = 44
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button 's origin by the length of the button and spacing
        
        for(index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    

    override var intrinsicContentSize: CGSize {
        let buttonSize = Int(frame.size.height)
        //let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        let width = (buttonSize + spacing) * starCount
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    func ratingButtonTaped(_ button: UIButton) {
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            
         //If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }

}
