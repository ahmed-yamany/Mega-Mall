//
//  ProductModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import Foundation

struct Product: Codable, Identifiable {
    var id = UUID()
    let image: String
    let name: String
    let price: String
    let review: Double
    let reviewCount: Int
}
