//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import Extensions

class StoreDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: MediumLabel!
    @IBOutlet weak var verifyLabel: RegularLabel!
    @IBOutlet weak var rateLabel: RegularLabel!
    @IBOutlet weak var locationLabel: RegularLabel!
    //
    @IBOutlet weak var followersLabel: MediumLabel!
    @IBOutlet weak var productLabel: MediumLabel!
    @IBOutlet weak var joinDateLabel: MediumLabel!
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    ///
    public func configure(with store: Store) {
        imageView.makeCircle(withWidth: 45, borderColor: .clear)
        imageView.image = UIImage(named: store.image)
        nameLabel.text = store.name
        verifyLabel.text = store.subtitle
        rateLabel.text = "\(store.rate)"
        locationLabel.text = store.location
        //
        followersLabel.text = "\(store.followres)"
        productLabel.text = "\(store.productsCount) Items"
        joinDateLabel.text = store.joinDate
    }
}
