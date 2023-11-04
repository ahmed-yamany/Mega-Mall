//
//  SortTableViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit

class SortTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: MediumLabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    //
    public func configure(with sort: Sort, selected: Bool) {
        selectionStyle = .none
        titleLabel.text = sort.title
        if selected {
            selectedImageView.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            selectedImageView.image = nil
        }
    }
}
