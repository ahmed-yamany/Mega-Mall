//
//  FilterTableViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit
import Extensions

class FilterTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: MediumLabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    //
    public func configure(with filter: Filter, selected: Bool) {
        selectionStyle = .none
        titleLabel.text = filter.title
        if selected {
            selectedImageView.image = UIImage(systemName: "checkmark.square.fill")
        } else {
            selectedImageView.image = UIImage(systemName: "square")
        }
    }
}
