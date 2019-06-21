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
        selectionStyle = .none
        self.textLabel?.text = name
    }
    
}

class SummaryCell: UITableViewCell {
    static let reuseIdentifier = "SummaryCell"
    
    func setup(_ summary: String) {
        selectionStyle = .none
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.text = summary
    }
}

class SkillsCell: UITableViewCell {
    static let reuseIdentifier = "SkillsCell"
    
    func setup(_ skills: [String]) {
        selectionStyle = .none
        let skills = skills.joined(separator: ", ")
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.text = skills
    }
    
}

class WorkExperienceCell: UITableViewCell {
    static let reuseIdentifier = "WorkExperienceCell"
    
    lazy var companyNameLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
    }()
    
    lazy var dateLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
    }()
    
    lazy var positionLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
    }()
    
    lazy var toolsUsedLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.systemFont(ofSize: UIFont.labelFontSize))
    }()
    
    lazy var summaryLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.systemFont(ofSize: UIFont.labelFontSize))
    }()
    
    lazy var projectsLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.systemFont(ofSize: UIFont.labelFontSize))
    }()
    
    lazy var additionalNotesLabel: UILabel! = {
        return getDefaultLabel(font: UIFont.systemFont(ofSize: UIFont.labelFontSize))
    }()
    
    private func getDefaultLabel (font: UIFont) -> UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        label.font = font
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let titleStack = UIStackView(arrangedSubviews: [companyNameLabel, dateLabel])
        titleStack.alignment = .fill
        titleStack.axis = .horizontal
        titleStack.distribution = .fillEqually
        titleStack.spacing = 8
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [titleStack, positionLabel, toolsUsedLabel
            , summaryLabel, projectsLabel, additionalNotesLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ workExperience: WorkExperience) {
        selectionStyle = .none
        companyNameLabel.text = workExperience.companyName
        dateLabel.text = workExperience.date
        positionLabel.text = workExperience.position
        toolsUsedLabel.text = "Tools Used: \(workExperience.toolsUsed.joined(separator: ", "))"
        summaryLabel.attributedText = NSAttributedString(string: workExperience.summary.joined(separator: "\n\n"))
        
        let attributedString = NSMutableAttributedString()
        workExperience.project.forEach {
            let name = $0.name
            let description = $0.description
            if !name.isEmpty && !description.isEmpty {
                attributedString.append(NSAttributedString(string: "\(name): \(description)\n"))
            }
            
        }
        projectsLabel.attributedText = attributedString
        
        additionalNotesLabel.text = workExperience.additionalNotes
        
    }
    
}

class EducationCell: UITableViewCell {
    static let reuseIdentifier = "EducationCell"
    
    func setup(_ education: String) {
        selectionStyle = .none
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.text = education
    }

}
