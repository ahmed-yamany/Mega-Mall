//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: MediumLabel!
    @IBOutlet weak var subtitlelabel: RegularLabel!
    @IBOutlet weak var dateLabel: RegularLabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(with news: News) {
        titleLabel.text = news.titel
        subtitlelabel.text = news.subtitle
        dateLabel.text = news.date
        imageView.image = UIImage(named: news.image)
    }
}
