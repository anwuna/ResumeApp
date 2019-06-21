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
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = LoadingView.shared
        registerCells()
        
        self.title = "RESUME"
        viewModel = ResumeViewModel(delegate: self, restClient: RestClient())
        viewModel.getResume()
        loadingView.startAnimating(in: self.tableView)
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
            return getSummaryCell(tableView, summary: viewModel.getSummary(index: indexPath.row))
        case .skills:
            return getSkillsCell(tableView, skills: viewModel.getSkills())
        case .workExperience:
            return getWorkExperienceCell(tableView, workExperience: viewModel.getWorkExperience(index: indexPath.row))
        case .education:
            return getEducationCell(tableView, education: viewModel.getEducation())
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
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.reuseIdentifier)
        tableView.register(SkillsCell.self, forCellReuseIdentifier: SkillsCell.reuseIdentifier)
        tableView.register(WorkExperienceCell.self, forCellReuseIdentifier: WorkExperienceCell.reuseIdentifier)
        tableView.register(EducationCell.self, forCellReuseIdentifier: EducationCell.reuseIdentifier)
        
    }
    
    private func getNameCell(_ tableView: UITableView, name: String) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.reuseIdentifier) as? NameCell {
            cell.setup(name)
            return cell
        }
        return UITableViewCell()
    }
    
    private func getSummaryCell(_ tableView: UITableView, summary: String) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.reuseIdentifier) as? SummaryCell {
            cell.setup(summary)
            return cell
        }
        return UITableViewCell()
    }
    
    private func getSkillsCell(_ tableView: UITableView, skills: [String]) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SkillsCell.reuseIdentifier) as? SkillsCell {
            cell.setup(skills)
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func getWorkExperienceCell(_ tableView: UITableView, workExperience: WorkExperience) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WorkExperienceCell.reuseIdentifier) as? WorkExperienceCell {
            cell.setup(workExperience)
            return cell
        }
        
        return UITableViewCell()

    }
    
    private func getEducationCell(_ tableView: UITableView, education: String) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EducationCell.reuseIdentifier) as? EducationCell {
            cell.setup(education)
            return cell
        }
        return UITableViewCell()
    }
}

extension ResumeTableViewController: ResumeViewModelProtocol {
    func onFetchDataSuccessful() {
        loadingView.stopAnimating()
        tableView.reloadData()
    }
    
    func onFetchDataFailed() {
        loadingView.stopAnimating()
        
        let alert = UIAlertController(title: "Error", message: "Unable to fetch resume at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    
}
