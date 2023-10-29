//
//  AddsModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 28/10/2023.
//

import Foundation

struct Adds: Codable, Identifiable {
    var id = UUID()
    let title: String
    let subtitle: String
    let image: String
}
