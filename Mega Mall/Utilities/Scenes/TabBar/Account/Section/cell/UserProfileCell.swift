//
//  UserProfileCollectionViewCell.swift
//  Lepgo
//
//  Created by Ahmed Yamany on 03/09/2023.
//

import UIKit

class UserProfileCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevrolImageView: UIImageView!
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTitleLabel()
    }
    ///
    private func updateTitleLabel() {
        titleLabel.font = .medium
    }
    ///
    func update(with model: AccountModel) {
        iconImageView.image = model.icon
        titleLabel.text = model.title
        updateTintColor(with: model.tintColor)
        if !model.isNavigatable { chevrolImageView.image = nil }
    }
    ///
    private func updateTintColor(with color: UIColor) {
        iconImageView.tintColor = color
        titleLabel.textColor = color
        chevrolImageView.tintColor = color
    }
}
