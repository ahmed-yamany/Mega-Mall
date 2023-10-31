//
//  CategoriesCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: MediumLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with category: Category) {
        imageBackgroundView.backgroundColor = category.backgroundColor
        imageView.image = UIImage(named: category.image)
        titleLabel.text = category.title
    }
}
