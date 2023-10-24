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
    @IBOutlet weak var button: LabelButton!
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
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
}
// MARK: - ViewModel
//
extension DescriptionView {
    /// The ViewModel structure for DescriptionView. It represents the data required to display information in the user interface.
    struct Model {
        let title: String
        let subtitle: String
        var buttonTitle: String?
    }
}
// MARK: - Configurations
//
extension DescriptionView {
    /// Configures the DescriptionView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: DescriptionView.Model) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        if let buttonTitle = viewModel.buttonTitle {
            button.isHidden = false
            button.setTitle(buttonTitle, for: .normal)
        } else {
            button.isHidden = true
        }
    }
}
