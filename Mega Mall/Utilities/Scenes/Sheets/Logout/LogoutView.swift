//
//  LogoutView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 06/11/2023.
//

import UIKit

class LogoutView: UIView {
    // MARK: IBOutlet
    //
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
    /// Loads the view from a nib file and adds it as a subview to the LogoutView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
    @IBAction func logoutButtonTapped(_ sender: WishlistButton) {
        UIApplication.shared.topMostViewController()?.dismiss(animated: true)
        TabBarViewModel.shared.logout()
    }
    @IBAction func cancellButtonAction(_ sender: SecondaryButton) {
        UIApplication.shared.topMostViewController()?.dismiss(animated: true)
    }
}
// MARK: - ViewModel
//
extension LogoutView {
    /// The ViewModel structure for LogoutView. It represents the data required to display information in the user interface.
    struct ViewModel {
    }
}
// MARK: - Configurations
//
extension LogoutView {
    /// Configures the LogoutView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: LogoutView.ViewModel) {
    }
}
