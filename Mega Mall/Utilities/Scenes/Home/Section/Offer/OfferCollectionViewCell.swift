//
//  OfferCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: H3Label!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViews()
    }
    public func configure(with offer: Offer) {
        layerCornerRadius = 16
        backgroundColor = offer.backgroundColor
        imageView.image = UIImage(named: offer.image)
        titleLabel.text = offer.title
    }
}
private extension OfferCollectionViewCell {
    func configureViews() {
        button.configuration = nil
        button.setTitle("Shop Now", for: .normal)
        button.titleLabel?.font = .h3
    }
}
