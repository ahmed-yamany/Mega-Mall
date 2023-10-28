//
//  OffersCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit
import Extensions
import MakeConstraints

class AddsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rectangleView: UIView!
    @IBOutlet weak var titleLabel: H2Label!
    @IBOutlet weak var subtitleLabel: SmallLabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    private(set) var isConfigured: Bool = false
    public func configure(with adds: Adds) {
        guard !isConfigured else { return}
        isConfigured = true
        titleLabel.text = adds.title
        subtitleLabel.text = adds.subtitle
        imageView.image = UIImage(named: adds.image)
    }
}
private extension AddsCollectionViewCell {
    func configureViews() {
        let cornerRadius = rectangleView.bounds.height / 2.0
        rectangleView.roundCorners(corners: [.topRight, .bottomRight], radius: cornerRadius)
        layerCornerRadius = 16
    }
}
