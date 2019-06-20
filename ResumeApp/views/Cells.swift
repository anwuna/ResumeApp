//
//  SkillsCell.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {
    static let reuseIdentifier = "NameCell"
    
    func setup(_ name: String) {
        self.textLabel?.text = name
    }
    
}

class SummaryCell: UITableViewCell {
    static let reuseIdentifier = "SummaryCell"
    
    func setup(_ summary: String) {
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.text = summary
    }
}

class SkillsCell: UITableViewCell {
    static let reuseIdentifier = "SkillsCell"
    
    func setup(_ skills: [String]) {
        let skills = skills.joined(separator: ", ")
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.text = skills
    }
    
}

class WorkExperienceCell: UITableViewCell {
    static let reuseIdentifier = "WorkExperienceCell"
    func setup(_ workExperience: WorkExperience) {
    }
    
}

class EducationCell: UITableViewCell {
    static let reuseIdentifier = "EducationCell"
    
    func setup(_ education: String) {
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.text = education
    }

}
