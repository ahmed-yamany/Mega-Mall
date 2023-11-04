//
//  FilterDelegate.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit

class FilterDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var filters: [Filter] = []
    let viewModel: FilterViewModel
    let tableView: UITableView
    init(viewModel: FilterViewModel, tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
        tableView.registerFromNib(FilterTableViewCell.self)
        super.init()
        Task { [unowned self] in
            filters = await viewModel.getFilters()
            tableView.reloadData()
        }
    }
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FilterTableViewCell.self, for: indexPath)
        let filter = filters[indexPath.row]
        let selected: Bool = viewModel.filters.contains(where: { $0 == filter })
        cell.configure(with: filter, selected: selected)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newFilter = filters[indexPath.row]
        ///
        if viewModel.filters.contains(newFilter) {
            viewModel.filters.removeAll(where: { $0 == newFilter})
        } else {
            viewModel.filters.append(newFilter)
        }
        ///
        tableView.reloadData()
    }
}

