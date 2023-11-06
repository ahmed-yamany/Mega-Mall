//
//  UserProfileModel.swift
//  Lepgo
//
//  Created by Ahmed Yamany on 03/09/2023.
//

import UIKit

struct AccountModel {
    let icon: UIImage?
    let title: String
    var isNavigatable: Bool = true
    var tintColor: UIColor = .megaPrimaryNavyBlack
    var action: () -> Void = {}
}
