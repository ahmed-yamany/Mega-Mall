//
//  ProductCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: MediumLabel!
    @IBOutlet weak var priceLabel: RegularLabel!
    @IBOutlet weak var reviewLabel: SmallLabel!
    @IBOutlet weak var reviewCountLabel: SmallLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(with product: Product) {
        imageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        priceLabel.text = "RP. \(product.price)"
        reviewLabel.text = "\(product.review)"
        reviewCountLabel.text = "Reviews \(product.reviewCount)"
    }
}
