//
//  ProductActionViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 30/10/2023.
//

import UIKit

class ProductActionViewController: SheetViewController {
    // MARK: Views
    let productActionView = ProductActionView()
    let product: Product
    init(product: Product) {
        self.product = product
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Action"
        addChild(productActionView)
        configureViews()
    }
}
// MARK: Configuation
private extension ProductActionViewController {
    func configureViews() {
        productActionView.configure(with: .init(addToWishlistAction: addToWishlistAction,
                                                shareAction: shareAction,
                                                addToCartAction: addToCartAction))
    }
}
// MARK: Actions
private extension ProductActionViewController {
    func addToWishlistAction() {
        TabBarViewModel.shared.whishies.append(product)
        dismiss(animated: true)
    }
    func shareAction() {
        print("product shared")
        dismiss(animated: true)
    }
    func addToCartAction() {
        TabBarViewModel.shared.cart.append(product)
        dismiss(animated: true)
    }
}
