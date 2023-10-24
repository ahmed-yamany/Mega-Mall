//
//  OnboardingTextField.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import UIKit
import MakeConstraints
import Extensions
import Combine

class OnboardingTextField: UIView {
    // MARK: IBOutlet
    //
    @IBOutlet weak private(set) var label: MediumLabel!
    @IBOutlet weak private(set) var textfield: UITextField!
    weak private(set) var viewModel: ViewModel?
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
    /// Loads the view from a nib file and adds it as a subview to the OnboardingTextField view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
    private func configureView() {
        heightConstraints(84)
        textfield.addPaddingLeft(16)
    }
}
// MARK: - ViewModel
//
extension OnboardingTextField {
    /// The ViewModel structure for OnboardingTextField.
    /// It represents the data required to display information in the user interface.
    class ViewModel {
        let model: Model
        @Published var text: String = ""
        init(model: Model) {
            self.model = model
        }
    }
    struct Model {
        let label: String
        let placeholder: String
        let securedTextField: Bool
        init(label: String, placeholder: String, securedTextField: Bool=false) {
            self.label = label
            self.placeholder = placeholder
            self.securedTextField = securedTextField
        }
    }
}
// MARK: - Configurations
//
extension OnboardingTextField {
    /// Configures the OnboardingTextField object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    public func configure(with viewModel: OnboardingTextField.ViewModel) {
        label.text = viewModel.model.label
        textfield.placeholder = viewModel.model.placeholder
        if viewModel.model.securedTextField {
            textfield.makeSecured(withTintColor: .megaSecondaryDarkGray)
        }
        self.viewModel = viewModel
    }
}
// MARK: - Actions
//
extension OnboardingTextField {
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        viewModel?.text = sender.text ?? ""
    }
}
