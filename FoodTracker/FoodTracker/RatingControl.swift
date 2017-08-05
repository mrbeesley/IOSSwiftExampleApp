//
//  RatingControl.swift
//  FoodTracker
//
//  Created by mbeesley on 8/1/17.
//  Copyright © 2017 mbeesley. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // make sure the buttons get setup when initialized
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        // make sure the buttons get setup when initialized
        setupButtons()
    }
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
            updateButtonSelctionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Private Methods
    private func setupButtons(){
        
        // remove existing buttons so they don't get double added
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // setup the images for filled vs non filled or highlighted stars
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        // create x number of buttons
        for index in 0..<starCount {

            // create the button
            let button = UIButton()
            
            // set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // add constraints to the button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack view
            addArrangedSubview(button)
            
            // add the button to the array list
            ratingButtons.append(button)
        }
        updateButtonSelctionStates()
    }
    
    private func updateButtonSelctionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // if the index of a button is less than the rating it should be selected
            button.isSelected = index < rating
            
            // add accessibility information
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // add accessibilty value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // assign the accessibilty hint and value
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
        
        
    }
    
    
    //MARK: button actions
    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the rating buttons array: \(ratingButtons)")
        }
        
        // the array is a 0 based index so to get the rating value you need to add 1
        let selectedRating = index + 1
        if selectedRating == rating {
            // this means the user tapped the currently selected star which should reset the rating selection
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
