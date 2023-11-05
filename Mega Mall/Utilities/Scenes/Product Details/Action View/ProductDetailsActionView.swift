//
//  ProductDetailsActionView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit

class ProductDetailsActionView: UIView {
    // MARK: IBOutlet
    //
    @IBOutlet weak var wishlistButton: WishlistButton!
    @IBOutlet weak var cartButton: PrimaryButton!
    //
    var product: Product!
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
    /// Loads the view from a nib file and adds it as a subview to the ProductDetailsActionView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
    ///
    @IBAction func addToWishlistButtonTapped(_ sender: WishlistButton) {
        if TabBarViewModel.shared.whishies.contains(where: { $0 == product }) {
            TabBarViewModel.shared.whishies.removeAll(where: { $0 == product })
        } else {
            TabBarViewModel.shared.whishies.append(product)
        }
        updateWishlistTitle()
    }
    ///
    @IBAction func addToCartButtonTapped(_ sender: PrimaryButton) {
        if TabBarViewModel.shared.cart.contains(where: { $0 == product }) {
            TabBarViewModel.shared.cart.removeAll(where: { $0 == product })
        } else {
            TabBarViewModel.shared.cart.append(product)
        }
        updateCartTitle()
    }
    ///
    private func updateWishlistTitle() {
        if TabBarViewModel.shared.whishies.contains(where: { $0 == product }) {
            wishlistButton.setTitle("Added", for: .normal)
        } else {
            wishlistButton.setTitle("Add", for: .normal)
        }
    }
    ///
    private func updateCartTitle() {
        if TabBarViewModel.shared.cart.contains(where: { $0 == product }) {
            cartButton.setTitle("Remove from Cart", for: .normal)
        } else {
            cartButton.setTitle("Add To Cart", for: .normal)
        }
    }
}
// MARK: - ViewModel
//
extension ProductDetailsActionView {
    /// The ViewModel structure for ProductDetailsActionView. 
    /// It represents the data required to display information in the user interface.
    struct ViewModel {
    }
}
// MARK: - Configurations
//
extension ProductDetailsActionView {
    /// Configures the ProductDetailsActionView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with product: Product) {
        self.product = product
        updateWishlistTitle()
        updateCartTitle()
    }
}
