//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {
    //
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: MediumLabel!
    @IBOutlet weak var priceLabel: RegularLabel!
    @IBOutlet weak var rateLabel: SmallLabel!
    @IBOutlet weak var revieNumberLabel: SmallLabel!
    //
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //
    public func configure(with product: Product) {
        imageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        priceLabel.text = product.price
        rateLabel.text = "RP. \(product.review)"
        revieNumberLabel.text = "\(product.reviewCount) Reviews"
    }
}
