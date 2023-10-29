//
//  Home.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import Foundation

struct Home: Codable {
    let sections: [Section]
}
//
enum SectionType: String, Codable {
    case adds
    case categories
    case products
    case offers
    case news
}
//
struct Section: Codable {
    let type: SectionType
    var title: String?
    var adds: [Adds]?
    var categories: [Category]?
    var products: [Product]?
    var offers: [Offer]?
    var news: [News]?
}
