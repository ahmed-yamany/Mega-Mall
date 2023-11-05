//
//  ProductImagesSupplementaryView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit
import MakeConstraints

class ProductImagesSupplementaryView: UICollectionReusableView {
    let label = MediumLabel()
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    //
    private func configureViews() {
        addSubview(label)
        label.textColor = .megaPrimaryNavyBlack
        label.centerYInSuperview()
        label.makeConstraints(leadingAnchor: leadingAnchor,
                              padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        label.text = "pla pla pla"
    }
}
