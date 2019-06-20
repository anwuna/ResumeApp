//
//  ResumeViewModel.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import Foundation

class ResumeViewModel {
    private let url = "https://gist.githubusercontent.com/anwuna/d4abb0325306b6984d80e1e1ede4a873/raw/f02194bf4f18e0d4e2e9f291828b0c3e775edfb9/json"
    private var restClient: RestClientProtocol
    private let sections:[Section] = Section.getSections()
    private var delegate: ResumeViewModelProtocol?
    private var resume = Resume()
    
    init(delegate: ResumeViewModelProtocol? = nil, restClient: RestClientProtocol) {
        self.restClient = restClient
        self.delegate = delegate
    }
    
    func noOfSections() -> Int {
        return sections.count
    }
    
    func noOfRows(in section: Int) -> Int{
        let section = sections[section]
        
        switch section {
        case .name:
            return 1
        case .summary:
            return resume.summary.count
        case .skills:
            return 1
        case .workExperience:
            return resume.workExperience.count
        case .education:
            return 1
        }
        
    }
    
    func indexOf(sectionString: String) -> Int {
        if let section = Section(rawValue: sectionString), let index = sections.firstIndex(of: section) {
            return index
        }
        return 0
    }
    
    func sectionTitleAt(index: Int) -> String{
        return sections[index].rawValue
    }
    
    func getSection(index: Int) -> Section {
        return sections[index]
    }
    
    func getName() -> String {
        return resume.name
    }
    
    func getSummary(index: Int) -> String {
        return resume.summary[index]
    }
    
    func getSkills() -> [String] {
        return resume.skills
    }
    
    func getWorkExperience(index: Int) -> WorkExperience {
        return resume.workExperience[index]
    }
    
    func getEducation() -> String {
        return resume.education
    }
    
    func getResume() {
        let successHandler: (Resume) -> Void = { resume in
            print(resume)
            self.handleSuccess(resume)
        }
        
        let errorHandler: (String) -> Void = { error in
            print(error)
            self.handleFailure()
        }
        
        restClient.get(urlString: url, successHandler: successHandler, errorHandler: errorHandler)
    }
    
    private func handleSuccess(_ resume: Resume) {
        self.resume = resume
        delegate?.onFetchDataSuccessful()
    }
    
    private func handleFailure() {
        delegate?.onFetchDataFailed()
    }
}

protocol ResumeViewModelProtocol {
    func onFetchDataSuccessful()
    func onFetchDataFailed()
}
