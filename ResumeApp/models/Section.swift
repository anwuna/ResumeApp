//
//  Sections.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import Foundation

enum Section: String, CaseIterable {
    case name = "NAME"
    case summary = "SUMMARY"
    case skills = "SKILLS"
    case workExperience = "WORK EXPERIENCE"
    case education = "EDUCATION"
    
    static func getSections() -> [Section] {
        return Section.allCases
    }
}
