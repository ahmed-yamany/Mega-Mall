//
//  SortDelegate.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit

class SortDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var sorts: [Sort] = []
    ///
    let viewModel: FilterViewModel
    let tableView: UITableView
    ///
    init(viewModel: FilterViewModel, tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
        tableView.registerFromNib(SortTableViewCell.self)
        super.init()
        ///
        Task { [unowned self] in
            sorts = await viewModel.getSorts()
            viewModel.sort = sorts.first
            tableView.reloadData()
        }
    }
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sorts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SortTableViewCell.self, for: indexPath)
        let sort = sorts[indexPath.row]
        let selected: Bool = viewModel.sort == sort
        cell.configure(with: sort, selected: selected)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sort = sorts[indexPath.row]
        ///
        viewModel.sort = sort
        ///
        tableView.reloadData()
    }
}
