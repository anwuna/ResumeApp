//
//  RestClientTests.swift
//  ResumeAppTests
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

@testable import ResumeApp
import XCTest

let testData = """
{
"name": "John Mathews",
"summary": [
"An Ingenious and passionate software developer with experience in the full software development lifecycle; from concept through to the delivery of a wide variety of solutions."
],
"skills": {
"competent_in": [
"C#",
"Swift"
],
"familiar_with": [
"Angular JS"
]
},
"work_experience": [
{
"company_name": "Fake Company Calgary",
"date": "Feb 2019 - Present",
"position": "iOS Developer",
"tools_used": [
"iOS using Swift",
"Git",
"TDD",
"Agile"
],
"summary": [
"Working on new features, bug fixes and refactoring the codebase of an iOS app for taking vibrations and temperature readings on machines. ",
"Creating test plans and writing UI and Unit tests for the app"
],
"project": [
{
"name": "Project 1",
"description": "project description"
}
],
"additional_notes": "Additional Notes "
}
],
"education": "University of Lagos, April 2014, Bachelor of Science in Computer Sciences"
}
"""

class RestClientTests: XCTestCase {
    let validURLString = "www.google.com"
    let invalidURLString = "Invalid Url"
    
    func test_successful_response() {
        let data = testData.data(using: .utf8)
        let url = URL(string: validURLString)!
        let session = MockURLSession()
        session.data = data
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.urlResponse = response
        
        let restClient = RestClient(session: session)
        
        var resume: Resume?
        
        restClient.get(urlString: validURLString, successHandler: {
            resume = $0
        }) { _ in }
        
        XCTAssertNotNil(resume)
        XCTAssertEqual(resume?.name, "John Mathews")
        XCTAssertEqual(resume?.summary.count, 1)
    }
    
    func test_InvalidUrl_Error_Returned_When_Url_Is_Invalid() {
        let session = MockURLSession()
        var errorString = ""
        
        let restClient = RestClient(session: session)
        restClient.get(urlString: invalidURLString, successHandler: {(resume: Resume) in
        }) { errorString = $0 }
        
        XCTAssertEqual(errorString, "Invalid Url")
        
    }
    
    func test_GenericErrorMessage_Returned_WhenErrorIsNotNil() {
        let session = MockURLSession()
        session.error = NSError(domain: "1001", code: 101, userInfo: nil)
        
        let restClient = RestClient(session: session)
        var errorString = ""
        restClient.get(urlString: validURLString, successHandler: {(resume: Resume) in }) {  errorString = $0 }
        
        XCTAssertEqual(errorString, NetworkError.genericError)
    }
    
    func test_genericError_Returned_When_Data_Is_Not_Valid_Json() {
        let data = "".data(using: .utf8)
        let url = URL(string: validURLString)!
        let session = MockURLSession()
        session.data = data
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.urlResponse = response
        
        let restClient = RestClient(session: session)
        
        var errorString = ""
        restClient.get(urlString: validURLString, successHandler: {(resume: Resume) in }) {  errorString = $0 }
        
        XCTAssertEqual(errorString, NetworkError.genericError)
    }
    
    func test_NoDataError_Returned_When_Data_Nil() {
        let url = URL(string: validURLString)!
        let session = MockURLSession()

        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.urlResponse = response
        
        let restClient = RestClient(session: session)
        
        var errorString = ""
        restClient.get(urlString: validURLString, successHandler: {(resume: Resume) in }) {  errorString = $0 }
        
        XCTAssertEqual(errorString, NetworkError.noDataError)
    }
}
