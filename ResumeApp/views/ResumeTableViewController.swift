//
//  ResumeTableViewController.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import UIKit

class ResumeTableViewController: UITableViewController {
    var viewModel: ResumeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        viewModel = ResumeViewModel(delegate: self, restClient: RestClient())
        viewModel.getResume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.noOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitleAt(index: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.getSection(index: indexPath.section)
        print(section)
        
        switch section {
        case .name:
            return getNameCell(tableView, name: viewModel.getName())
        case .summary:
            return getSummaryCell(summary: viewModel.getSummary(index: indexPath.row))
        case .skills:
            return getSkillsCell(skills: viewModel.getSkills())
        case .workExperience:
            return getWorkExperienceCell(workExperience: viewModel.getWorkExperience(index: indexPath.row))
        case .education:
            return getEducationCell(education: viewModel.getEducation())
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

}

extension ResumeTableViewController {
    private func registerCells() {
        
        tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.reuseIdentifier)
    }
    
    private func getNameCell(_ tableView: UITableView, name: String) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.reuseIdentifier) as? NameCell {
            cell.setup(name)
            return cell
        }
        return UITableViewCell()
    }
    
    private func getSummaryCell(summary: String) -> SummaryCell {
        let cell = SummaryCell()
        cell.setup(summary)
        return cell
    }
    
    private func getSkillsCell(skills: [String]) -> SkillsCell {
        let cell = SkillsCell()
        cell.setup(skills)
        return cell
    }
    
    private func getWorkExperienceCell(workExperience: WorkExperience) -> WorkExperienceCell {
        let cell = WorkExperienceCell()
        cell.setup(workExperience)
        return cell
    }
    
    private func getEducationCell(education: String) -> EducationCell {
        let cell = EducationCell()
        cell.setup(education)
        return cell
    }
}

extension ResumeTableViewController: ResumeViewModelProtocol {
    func onFetchDataSuccessful() {
        tableView.reloadData()
    }
    
    func onFetchDataFailed() {
        //todo: Handle errors
    }
    
    
}
