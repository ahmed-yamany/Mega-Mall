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
    init(product: Product) {
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
        print("product added to wishlist")
        dismiss(animated: true)
    }
    func shareAction() {
        print("product shared")
        dismiss(animated: true)
    }
    func addToCartAction() {
        print("product added to cart")
        dismiss(animated: true)
    }
}
