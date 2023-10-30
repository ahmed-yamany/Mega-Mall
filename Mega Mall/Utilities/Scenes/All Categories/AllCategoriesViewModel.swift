//
//  AllCategoriesViewModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 30/10/2023.
//

import Foundation
import Combine
class AllCategoriesViewModel {
    var cancellableSet: Set<AnyCancellable> = []
    func getCategories() -> AnyPublisher<[Category], Never> {
        let categories =  Just([
            Category(title: "Foods", image: "data-category-1", color: "#E4F3EA"),
            Category(title: "Gift", image: "data-category-2", color: "#FFECE8"),
            Category(title: "Fashion", image: "data-category-3", color: "#FFF6E4"),
            Category(title: "Gadget", image: "data-category-4", color: "#F1EDFC"),
            Category(title: "Foods", image: "data-category-1", color: "#E4F3EA"),
            Category(title: "Gift", image: "data-category-2", color: "#FFECE8")
        ]).eraseToAnyPublisher()
        return categories
    }
}
