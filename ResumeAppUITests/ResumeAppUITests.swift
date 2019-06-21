//
//  ResumeAppUITests.swift
//  ResumeAppUITests
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import XCTest

class ResumeAppUITests: XCTestCase {

    var application: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    func testHeadersExists() {
        
        let tablesQuery = XCUIApplication().tables
        XCTAssertTrue(tablesQuery.staticTexts["NAME"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["SUMMARY"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["SKILLS"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["WORK EXPERIENCE"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["EDUCATION"].exists)
        
    }
    
    func testResumeNameIs_ChibunduAnwuna() {
        
        let tablesQuery = application.tables
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mr. Chibundu John Anwuna"]/*[[".cells.staticTexts[\"Mr. Chibundu John Anwuna\"]",".staticTexts[\"Mr. Chibundu John Anwuna\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
    
    func testSummaryContainsCertainText() {
        let paragraph1 = "An Ingenious and passionate software"
        let paragraph2 = "Extensive knowledge in software development"
        let paragraph3 = "Excellent troubleshooting skills, debugging"

        for pargs in [paragraph1, paragraph2, paragraph3] {
            let elementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", pargs))
            XCTAssertGreaterThanOrEqual(elementQuery.count, 1)
        }
    }
    
    func testCompanyNames_Exists(){
        let tableQuery = application.tables
        XCTAssertTrue(tableQuery.staticTexts["SKF Calgary"].exists)
        XCTAssertTrue(tableQuery.staticTexts["SystemSpecs, Nigeria"].exists)
        XCTAssertTrue(tableQuery.staticTexts["Interswitch Group"].exists)
        XCTAssertTrue(tableQuery.staticTexts["MindWorks Solutions Limited "].exists)
        
    }
}
