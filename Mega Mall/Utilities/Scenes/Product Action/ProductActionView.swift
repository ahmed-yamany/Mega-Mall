//
//  ProductActionView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 30/10/2023.
//

import UIKit

class ProductActionView: UIView {
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
    /// Loads the view from a nib file and adds it as a subview to the ProductActionView view.
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
extension ProductActionView {
    /// The ViewModel structure for ProductActionView.
    ///  It represents the data required to display information in the user interface.
    struct ViewModel {
        let addToWishlistAction: () -> Void
        let shareAction: () -> Void
        let addToCartAction: () -> Void
    }
}
// MARK: - Configurations
//
extension ProductActionView {
    /// Configures the ProductActionView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: ProductActionView.ViewModel) {
        self.viewModel = viewModel
    }
}
// MARK: Actions
//
extension ProductActionView {
    @IBAction func addWishlistButtonAction(_ sender: Any) {
        viewModel?.addToWishlistAction()
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        viewModel?.shareAction()
    }
    @IBAction func addCartButtonAction(_ sender: Any) {
        viewModel?.addToCartAction()
    }
}
