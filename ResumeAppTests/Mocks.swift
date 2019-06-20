//
//  Mocks.swift
//  ResumeAppTests
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import XCTest
@testable import ResumeApp

class MockRestClient: RestClientProtocol {
    var expectation: XCTestExpectation?
    var mockResume: Resume?
    
    func get<T>(urlString: String, successHandler: @escaping (T) -> Void, errorHandler: @escaping ErrorHandler) where T: Decodable {
        expectation?.fulfill()
        if let resume = mockResume as? T {
            successHandler(resume)
        }
    }
}

class MockViewModelImpl: ResumeViewModelProtocol {
    var successExpectation: XCTestExpectation?
    var failureExpectation: XCTestExpectation?
    
    func onFetchDataSuccessful() {
        successExpectation?.fulfill()
    }
    
    func onFetchDataFailed() {
        failureExpectation?.fulfill()
    }
    
}


class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
    var mockData: Data? = nil
    var mockError: Error? = nil
    var mockUrlResponse: URLResponse?  = nil
    
    override init() {
        super.init()
    }
    
    override func resume() {
        completionHandler(mockData, mockUrlResponse, mockError)
    }
}


class MockURLSession: URLSession {
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let mockTask = MockURLSessionDataTask()
        
        mockTask.completionHandler = completionHandler
        mockTask.mockData = self.data
        mockTask.mockError = self.error
        mockTask.mockUrlResponse = self.urlResponse
        
        return mockTask
    }
    
}
