//
//  FilterView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 02/11/2023.
//

import UIKit
import MakeConstraints
import Extensions

class FilterView: UIView {
    // MARK: IBOutlet
    //
    @IBOutlet weak var segmentControl: CustomSegmetedControl!
    @IBOutlet weak var tableView: UITableView!
    //
    // MARK: Properities
    var viewModel: FilterViewModel!
    var sorts: [Sort] = []
    //
    lazy var filterDelegate = FilterDelegate(viewModel: viewModel, tableView: tableView)
    lazy var sortDelegate = SortDelegate(viewModel: viewModel, tableView: tableView)
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    /// Loads the view from a nib file and adds it as a subview to the FilterView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
}
// MARK: - ViewModel
//
extension FilterView {
    /// The ViewModel structure for FilterView. It represents the data required to display information in the user interface.
    struct ViewModel {
    }
}
// MARK: - Configurations
//
extension FilterView {
    /// Configures the FilterView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: FilterViewModel) {
        self.viewModel = viewModel
        configureViews()
    }
}
// MARK: - Configure Views
//
private extension FilterView {
    func configureViews() {
        configureSegmentControl()
    }
    func configureSegmentControl() {
        segmentControl.delegate = self
        segmentControl.configure(buttonTitles: ["Filter", "Sorting"])
    }
}

extension FilterView: SegmentControlDelegate {
    func segmentControl(_ segmentControl: CustomSegmetedControl, updateSelected button: UIButton) {
        button.setTitleColor(.megaPrimaryNavyBlack, for: .normal)
        button.titleLabel?.font = .medium
    }
    func segmentControl(_ segmentControl: CustomSegmetedControl, updateUnSelected button: UIButton) {
        button.setTitleColor(.megaPrimaryNavyBlack, for: .normal)
        button.titleLabel?.font = .regular
    }
    func segmentControl(_ segmentControl: CustomSegmetedControl, didSelectSegmentAt index: Int) {
        if index == 0 {
            tableView.delegate = filterDelegate
            tableView.dataSource = filterDelegate
        } else {
            tableView.delegate = sortDelegate
            tableView.dataSource = sortDelegate
        }
        tableView.reloadData()
    }
}
