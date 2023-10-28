//
//  OfferModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import UIKit

struct Offer: Codable {
    let title: String
    let image: String
    let color: String
    var backgroundColor: UIColor? {
        UIColor(hexString: color)
    }
}
