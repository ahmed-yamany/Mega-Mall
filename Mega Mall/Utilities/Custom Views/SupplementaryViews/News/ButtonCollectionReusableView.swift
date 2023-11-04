//
//  NewsCollectionReusableView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import UIKit
import MakeConstraints

class ButtonCollectionReusableView: UICollectionReusableView {
    let button = SecondaryButton()
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    public func configure(with viewModel: ViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        button.addTarget(viewModel.target, action: viewModel.action, for: .touchUpInside)
    }
}
// MARK: - ViewModel
//
extension ButtonCollectionReusableView {
    /// The ViewModel structure for MegaCollectionReusableView.
    ///  It represents the data required to display information in the user interface.
    struct ViewModel {
        let title: String
        let target: Any?
        var action: Selector
    }
}
//
private extension ButtonCollectionReusableView {
    func configureViews() {
        addSubview(button)
        button.fillXSuperView()
        button.centerYInSuperview()
    }
}
