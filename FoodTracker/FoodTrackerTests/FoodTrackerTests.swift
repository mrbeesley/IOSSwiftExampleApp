//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by mbeesley on 7/31/17.
//  Copyright © 2017 mbeesley. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: meal class tests
    func testMealInitializationSucceeds() {
        
        // zero rating
        let zeroRatingMeal = Meal.init(name: "zero meal", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // highest possible rating
        let positiveRatingMeal = Meal.init(name: "high rating", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails() {
        
        // confirm you get nil when passed a negative meal rating
        let negativeRatingMeal = Meal.init(name: "negative meal", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // confirm you get a nil when name is empty
        let emptyNameMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyNameMeal)
        
        // confirm you get a nil when passing a rating above the max range
        let maxedRatingMeal = Meal.init(name: "Over Max Rating", photo: nil, rating: 11)
        XCTAssertNil(maxedRatingMeal)
        
    }
    
}
