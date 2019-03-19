//
//  ContactAppPracticalUITests.swift
//  ContactAppPracticalUITests
//
//  Created by Muvi on 16/03/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import XCTest

class ContactAppPracticalUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllEmptyField() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.navigationBars["Contacts"].buttons["ADD"].tap()
        app.navigationBars["ContactAppPractical.CreateContactView"].buttons["DONE"].tap()
        app.alerts["ALERT!"].buttons["dismiss"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testTypeInFields() {
        
        let app = XCUIApplication()
        app.navigationBars["Contacts"].buttons["ADD"].tap()
        
        let tablesQuery2 = app.tables
        let emailTextField = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".cells.textFields[\"email\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        nKey.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        let mobileTextField = tablesQuery2/*@START_MENU_TOKEN@*/.textFields["mobile"]/*[[".cells.textFields[\"mobile\"]",".textFields[\"mobile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mobileTextField.tap()
        
        let app2 = XCUIApplication()
        app2/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let key3 = app2/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        
        let key4 = app2/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key4.tap()
        
        let key5 = app2/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key5.tap()
        
        let tablesQuery = app2.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["First Name"]/*[[".cells.staticTexts[\"First Name\"]",".staticTexts[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        nKey.tap()
        
        let aKey = app2/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let rKey = app2/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let uKey = app2/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uKey.tap()
        app2/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        oKey.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        uKey.tap()
        
        let zKey = app2/*@START_MENU_TOKEN@*/.keys["z"]/*[[".keyboards.keys[\"z\"]",".keys[\"z\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        zKey.tap()
        uKey.tap()
        app2/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["ContactAppPractical.CreateContactView"].buttons["DONE"].tap()
        app.alerts["ALERT!"].buttons["dismiss"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }

}
