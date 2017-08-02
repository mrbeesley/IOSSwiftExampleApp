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
    var rating = 0
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
        
        // create x number of buttons
        for _ in 0..<starCount {

            // create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            // add constraints to the button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack view
            addArrangedSubview(button)
            
            // add the button to the array list
            ratingButtons.append(button)
        }
    }
    
    
    //MARK: button actions
    func ratingButtonTapped(button: UIButton) {
        print("Button was Pressed! :)")
    }
}
