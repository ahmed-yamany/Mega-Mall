//
//  DescriptionView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit
import MakeConstraints

class DescriptionView: UIView {
    // MARK: IBOutlet
    //
    @IBOutlet weak var titleLabel: H1Label!
    @IBOutlet weak var subtitleLabel: MediumLabel!
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureView()
    }
    /// Loads the view from a nib file and adds it as a subview to the DescriptionView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
    private func configureView() {
        heightConstraints(66)
    }
}
// MARK: - ViewModel
//
extension DescriptionView {
    /// The ViewModel structure for DescriptionView. It represents the data required to display information in the user interface.
    struct ViewModel {
        let title: String
        let subtitle: String
    }
}
// MARK: - Configurations
//
extension DescriptionView {
    /// Configures the DescriptionView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: DescriptionView.ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
