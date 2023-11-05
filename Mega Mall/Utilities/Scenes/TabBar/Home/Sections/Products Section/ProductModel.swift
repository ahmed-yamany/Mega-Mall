//
//  ProductModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    var id = UUID()
    let image: String
    let name: String
    let price: String
    let review: Double
    let reviewCount: Int
    let availableCount: Int
    // swiftlint: disable all
    var store: Store {
        .init(image: "yamany", name: "Shop Larson Electronic", subtitle: "Official Store", rate: 4.5)
    }
    var description: String {
        """
The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers. The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers
""".replacingOccurrences(of: ".", with: ".\n\n")
        // swiftlint: disable all
    }
    
    var featuredProducts: [Product] {
        [
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 100),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120, availableCount: 10),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 50),
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 0),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120, availableCount: 100),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86, availableCount: 0)
        ]
    }
    var reviews: [Review] { [.init(), .init(), .init()]}
}
