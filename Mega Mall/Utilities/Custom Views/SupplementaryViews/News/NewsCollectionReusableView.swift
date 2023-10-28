//
//  NewsCollectionReusableView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import UIKit
import MakeConstraints

class NewsCollectionReusableView: UICollectionReusableView {
    let button = UIButton()
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
        addSubview(button)
        button.fillXSuperView()
        button.centerYInSuperview()
        button.heightConstraints(44)
        button.layerCornerRadius = 8
        button.layerBorderWidth = 1
        button.layerBorderColor = .megaPrimaryNavyBlack
        button.configuration = nil
        button.setTitle("See All News", for: .normal)
        button.setTitleColor(.megaPrimaryNavyBlack, for: .normal)
        button.titleLabel?.font = .medium
    }
}
