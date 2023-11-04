//
//  LoginAlertView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit

class LoginAlertView: UIView {
    // MARK: Properties
    //
    var viewModel: ViewModel?
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
    /// Loads the view from a nib file and adds it as a subview to the LoginAlertView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
    //
    @IBAction func loginButtonTapped(_ sender: PrimaryButton) {
        viewModel?.buttonAction()
    }
}
// MARK: - ViewModel
//
extension LoginAlertView {
    /// The ViewModel structure for LoginAlertView. It represents the data required to display information in the user interface.
    struct ViewModel {
        let buttonAction: () -> Void
    }
}
// MARK: - Configurations
//
extension LoginAlertView {
    /// Configures the LoginAlertView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: LoginAlertView.ViewModel) {
        self.viewModel = viewModel
    }
}
