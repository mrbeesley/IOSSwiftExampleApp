//
//  RatingControl.swift
//  FoodTracker
//
//  Created by mbeesley on 8/1/17.
//  Copyright © 2017 mbeesley. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    
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
    
    //MARK: Private Methods
    private func setupButtons(){
        
        // create x number of buttons
        for _ in 0..<5 {

            // create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            // add constraints to the button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            
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
