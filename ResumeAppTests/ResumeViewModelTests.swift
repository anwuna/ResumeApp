//
//  ResumeViewModelTests
//  ResumeViewModelTests
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import XCTest
@testable import ResumeApp

class ResumeViewModelTests: XCTestCase {
    
    func test_on_fetchResume_RestClient_getMethod_IsCalled() {
        let restClient = MockRestClient()
        restClient.expectation = self.expectation(description: "Get Method on RestClient is called")
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        
        waitForExpectations(timeout: 1)
    }
    
    func test_OnGetResume_Successful_onFetchDataSuccessful_should_Be_Called() {
        let data = testData.data(using: .utf8)
        let url = URL(string: "www.google.com")!
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let session = MockURLSession()
        session.data = data
        session.urlResponse = response
        
        let queue = DispatchQueue(label: "queue")
        let restClient = RestClient(session: session, queue: queue)
        let delegate = MockViewModelImpl()
        delegate.successExpectation = self.expectation(description: "onFetchDataSuccessful is called")
        let viewModel = ResumeViewModel(delegate: delegate, restClient: restClient)
        viewModel.getResume()
        queue.sync {}
        
        waitForExpectations(timeout: 1)
    }
    
    func test_OnGetResume_Failure_onFetchDataFailed_should_Be_Called() {

        let session = MockURLSession()
        let restClient = RestClient(session: session)
        let delegate = MockViewModelImpl()
        delegate.failureExpectation = self.expectation(description: "onFetchDataFailed is called")
        let viewModel = ResumeViewModel(delegate: delegate, restClient: restClient)
        viewModel.getResume()
        
        waitForExpectations(timeout: 1)
    }

}


extension ResumeViewModelTests {
    
    func test_no_of_sections_is_Five() {
        let restClient = MockRestClient()
        let viewModel = ResumeViewModel(restClient: restClient)
        XCTAssertEqual(viewModel.noOfSections() , 5)
    }
    
    func test_section_name_should_Be_Empty() {
        let viewModel = ResumeViewModel(restClient: MockRestClient())
        XCTAssertTrue(viewModel.getName().isEmpty)
    }
    
    func test_section_name_should_Not_Be_Empty() {
        var resume = Resume()
        resume.name = "John"
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        
        XCTAssertEqual(viewModel.getName(), "John")
    }
    
    func test_no_of_rows_in_Name_Section_ShouldBeOne(){
        var resume = Resume()
        resume.name = "John"
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        
        let rowCount = viewModel.noOfRows(in: 0)
        XCTAssertEqual(rowCount, 1)
    }
    
    func test_indexOf_Section_should_returnZero_For_Invalid_Section() {
        let viewModel =  ResumeViewModel()
        XCTAssertEqual(viewModel.indexOf(sectionString: "Invalid section"), 0)
    }
    
    func test_no_of_rows_in_Education_Section_ShouldBeOne(){
        var resume = Resume()
        resume.name = "John"
        resume.education = "University of Cambridge"
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        let sectionIndex = viewModel.indexOf(sectionString: "EDUCATION")
        let rowCount = viewModel.noOfRows(in: sectionIndex)
        XCTAssertEqual(rowCount, 1)
    }
    
    func test_no_of_rows_for_skills_Section_ShouldBeOne() {
        var resume = Resume()
        resume.skills = ["C#", "SWIFT"]
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        let sectionIndex = viewModel.indexOf(sectionString: "SKILLS")
        let rowCount = viewModel.noOfRows(in: sectionIndex)
        
        XCTAssertEqual(rowCount, 1)
    }
    
    func test_Summary_Should_Equal_Summary_In_DataSource() {
        var summaries = ["Summary1", "Summary2"]
        var resume = Resume()
        resume.summary = summaries
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        
        XCTAssertEqual(viewModel.getSummary(index: 0), summaries[0])
        XCTAssertEqual(viewModel.getSummary(index: 1), summaries[1])
    }
    
    func test_WorkExperience_Should_Equal_WorkExperience_In_DataSource() {
        var workExperience1 = WorkExperience()
        workExperience1.companyName = "Company1"
        
        var workExperience2 = WorkExperience()
        workExperience2.companyName = "Company2"
        
        var resume = Resume()
        resume.workExperience = [workExperience1, workExperience2]
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        
        XCTAssertEqual(viewModel.getWorkExperience(index: 0), workExperience1)
        XCTAssertEqual(viewModel.getWorkExperience(index: 1), workExperience2)
        
    }
    
    func test_no_of_rows_in_Section_ShouldEqual_DataSource(){
        var resume = Resume()
        resume.skills = ["C#", ".Net"]
        resume.summary = ["Summary1", "Summary2"]
        var workExperience = WorkExperience()
        workExperience.companyName = "Company1"
        resume.workExperience = [workExperience]
        
        let restClient = MockRestClient()
        restClient.mockResume = resume
        
        let viewModel = ResumeViewModel(restClient: restClient)
        viewModel.getResume()
        
        let summaryRowCount = viewModel.noOfRows(in: viewModel.indexOf(sectionString: "SUMMARY"))
        let workExperienceRowCount = viewModel.noOfRows(in: viewModel.indexOf(sectionString: "WORK EXPERIENCE"))
        
        XCTAssertEqual(summaryRowCount, resume.summary.count)
        XCTAssertEqual(workExperienceRowCount, resume.workExperience.count)
    }

    
}
