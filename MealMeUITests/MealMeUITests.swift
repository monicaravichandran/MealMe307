//
//  MealMeUITests.swift
//  MealMeUITests
//
//  Created by Kalyan Vejalla on 4/7/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["startUpView"].exists
    }
}

class MealMeUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        //XCTAssertTrue(app.isDisplayingOnboarding)
        //print(app.buttons)//["Google Sign In Button"].tap()
        XCTAssertTrue(app.isDisplayingOnboarding)
    }

}
