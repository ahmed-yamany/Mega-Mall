//
//  CategoriesModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import UIKit
import Extensions

struct Category: Codable, Identifiable {
    var id = UUID()
    let title: String
    let image: String
    let color: String
    var backgroundColor: UIColor? {
        UIColor(hexString: color)
    }
}
