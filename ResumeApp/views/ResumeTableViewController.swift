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
        viewModel = ResumeViewModel(delegate: self, restClient: RestClient())
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
        return UITableViewCell()
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
