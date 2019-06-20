//
//  ResumeViewModel.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import Foundation

class ResumeViewModel {
    private let url = "https://gist.githubusercontent.com/anwuna/d4abb0325306b6984d80e1e1ede4a873/raw/36cdb3404ae6f99de7feb7e4d213afdb6e8c846d/json"
    private var restClient: RestClientProtocol
    private let sections:[Section] = Section.getSections()
    private var delegate: ResumeViewModelProtocol?
    private var resume = Resume()
    
    var resumeName: String {
        return resume.name
    }
    
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
            return resume.skills.count
        case .workExperience:
            return resume.workExperience.count
        case .education:
            return 1
        }
        
    }
    
    func indexOf(sectionString: String) -> Int {
        if let section = Section(rawValue: sectionString), let index = section.firstIndex(of: section) {
            return index
        }
        return 0
    }
    
    func sectionTitleAt(index: Int) -> String{
        return sections[index].rawValue
    }
    
    func section(index: Int) -> Section {
        
    }
    
    func cellDataForRow(at indexPath: IndexPath) ->(Section, Any) {
        let section = sections[indexPath.section]
        
        switch section {
        case .name:
            return 1
        case .summary:
            return resume.summary.count
        case .skills:
            return resume.skills.count
        case .workExperience:
            return resume.workExperience.count
        case .education:
            return 1
        }
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
