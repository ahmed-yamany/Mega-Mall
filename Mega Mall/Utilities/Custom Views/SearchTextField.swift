//
//  SearchTextField.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import MakeConstraints
import Extensions

class SearchTextField: UITextField {
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}
// MARK: - Congigure View
//
extension SearchTextField {
    private func configureView() {
        heightConstraints(52)
        backgroundColor = .megaSecondaryOffGray
        layerCornerRadius = 10
        addPaddingLeft(20)
        addPaddingRightIcon(.megaSearch, padding: 16)
        borderStyle = .none
        placeholder = L10n.App.Search.TextField.placeholder
    }
}
