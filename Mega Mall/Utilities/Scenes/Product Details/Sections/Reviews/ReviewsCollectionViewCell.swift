//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import Extensions

class ReviewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: MediumLabel!
    @IBOutlet weak var dateLabel: RegularLabel!
    @IBOutlet weak var textLabel: RegularLabel!
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    ///
    public func configure(with review: Review) {
        imageView.makeCircle(withWidth: 40, borderColor: .clear)
        imageView.image = UIImage(named: review.image)
        nameLabel.text = review.name
        dateLabel.text = review.date
        textLabel.text = review.text
    }
}
