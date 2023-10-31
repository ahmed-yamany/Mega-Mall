//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

class DetailNewsCollectionViewCell: UICollectionViewCell {
    ///
    @IBOutlet weak var titleLabel: H3Label!
    @IBOutlet weak var dateLabel: RegularLabel!
    @IBOutlet weak var newsLabel: MediumLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with news: News) {
        titleLabel.text = news.titel
        dateLabel.text = news.date
        prettyFiyNewsLabelText()
    }
    //
    func prettyFiyNewsLabelText() {
        newsLabel.text = newsLabel.text?.replacingOccurrences(of: ".", with: ".\n\n")
    }
}
