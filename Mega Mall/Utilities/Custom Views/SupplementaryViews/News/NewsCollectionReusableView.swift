//
//  NewsCollectionReusableView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import UIKit
import MakeConstraints

class NewsCollectionReusableView: UICollectionReusableView {
    let label = UILabel()
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
}

private extension NewsCollectionReusableView {
    func configureViews() {
        addSubview(label)
        label.fillXSuperView()
        label.centerYInSuperview()
        label.heightConstraints(44)
        ///
        label.layerCornerRadius = 8
        label.layerBorderWidth = 1
        label.layerBorderColor = .megaPrimaryNavyBlack
        ///
        label.text = "See All News"
        label.textColor = .megaPrimaryNavyBlack
        label.textAlignment = .center
        label.font = .medium
    }
}
