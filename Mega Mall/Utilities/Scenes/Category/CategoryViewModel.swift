import Foundation
import Combine

// MARK: CategoryViewModel
//
class CategoryViewModel {
    var cancellableSet: Set<AnyCancellable> = .init()
    let category: Category
    init(category: Category) {
        self.category = category
    }
    public func getProducts() -> AnyPublisher<[Product], Never> {
        Just([
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86),
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86)
        ])
        .eraseToAnyPublisher()
    }
}

// MARK: Private Handlers
//
private extension CategoryViewModel {}
