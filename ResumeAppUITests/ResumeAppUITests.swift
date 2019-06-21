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

    func test_headersExists() {
        let tablesQuery = XCUIApplication().tables
        XCTAssertTrue(tablesQuery.staticTexts["NAME"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["SUMMARY"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["SKILLS"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["WORK EXPERIENCE"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["EDUCATION"].exists)
        
    }
    
    func test_resumeName_Exists() {
        let tablesQuery = application.tables
        XCTAssertTrue(tablesQuery.staticTexts["Mr. Chibundu John Anwuna"].exists)
    }
    
    func test_summaries_Exists() {
        let paragraph1 = "An Ingenious and passionate software"
        let paragraph2 = "Extensive knowledge in software development"
        let paragraph3 = "Excellent troubleshooting skills, debugging"

        for pargs in [paragraph1, paragraph2, paragraph3] {
            let elementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", pargs))
            XCTAssertEqual(elementQuery.count, 1)
        }
    }
    
    func test_skills_Exists() {
        let skills = "C#, Swift, Ruby, ASP.NET, JavaScript"
        let skillsElementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", skills))
        XCTAssertEqual(skillsElementQuery.count, 1)
    }
    
    func test_companyNames_Exists(){
        let tableQuery = application.tables
        XCTAssertTrue(tableQuery.staticTexts["SKF Calgary"].exists)
        XCTAssertTrue(tableQuery.staticTexts["SystemSpecs, Nigeria"].exists)
        XCTAssertTrue(tableQuery.staticTexts["Interswitch Group"].exists)
        XCTAssertTrue(tableQuery.staticTexts["MindWorks Solutions Limited "].exists)
        
    }
    
    func test_education_Exists() {
        let education = "University of Lagos"
        let educationElementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", education))
        XCTAssertEqual(educationElementQuery.count, 1)
    }
    
    func test_refreshButton_Exists() {
        XCTAssertTrue(application.navigationBars["RESUME"].buttons["Refresh"].exists)
    }
    
    func test_canRefresh_TableView() {
        let app = XCUIApplication()
        app.navigationBars["RESUME"].buttons["Refresh"].tap()
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.staticTexts["Mr. Chibundu John Anwuna"].exists)
        
        let summary = "An Ingenious and passionate software"
        let summaryElementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", summary))
        XCTAssertEqual(summaryElementQuery.count, 1)
        
        let skills = "C#, Swift, Ruby, ASP.NET, JavaScript"
        let skillsElementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", skills))
        XCTAssertEqual(skillsElementQuery.count, 1)
        XCTAssertTrue(tablesQuery.staticTexts["SKF Calgary"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["SystemSpecs, Nigeria"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["Interswitch Group"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["MindWorks Solutions Limited "].exists)
        
        let education = "University of Lagos"
        let educationElementQuery = application.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", education))
        XCTAssertEqual(educationElementQuery.count, 1)
    }
}
