//
//  Store.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import Foundation

struct Store {
    let image: String
    let name: String
    let subtitle: String
    let rate: Double
    var location: String { "Jawa Barat, Bandung (Jam Buka 08:00-21:00)"}
    var followres: Int { 23 }
    var productsCount: Int { 150 }
    var joinDate: String { "20 Oct 2021" }
    var products: [Product] {
        // swiftlint: disable all
        [
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 100),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120, availableCount: 10),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 50),
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 0),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120, availableCount: 100),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 0),
        ]
    }
    // swiftlint: enable all
}
