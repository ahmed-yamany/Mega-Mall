import Foundation
import Combine

// MARK: HomeViewModel
//
class HomeViewModel {
    // swiftlint: disable all
    var cancellableSet: Set<AnyCancellable> = []
    public func getHome() -> AnyPublisher<Home, Never> {
        let adds: [Adds] = [
            .init(title: "Free Shipping During PPKM!", subtitle: "Period May - August 2021", image: "data-adds-1"),
            .init(title: "Fast Delivery", subtitle: "Period August - Octoper 2021", image: "data-adds-2"),
            .init(title: "Free Shipping During PPKM!", subtitle: "Period May - August 2021", image: "data-adds-3")
        ]
        let categories: [Category] = [
            .init(title: "Foods", image: "data-category-1", color: "#E4F3EA"),
            .init(title: "Gift", image: "data-category-2", color: "#FFECE8"),
            .init(title: "Fashion", image: "data-category-3", color: "#FFF6E4"),
            .init(title: "Gadget", image: "data-category-4", color: "#F1EDFC"),
            .init(title: "Foods", image: "data-category-1", color: "#E4F3EA"),
            .init(title: "Gift", image: "data-category-2", color: "#FFECE8"),
            .init(title: "Fashion", image: "data-category-3", color: "#FFF6E4"),
            .init(title: "Gadget", image: "data-category-4", color: "#F1EDFC"),
            .init(title: "Foods", image: "data-category-1", color: "#E4F3EA"),
            .init(title: "Gift", image: "data-category-2", color: "#FFECE8"),
            .init(title: "Fashion", image: "data-category-3", color: "#FFF6E4"),
            .init(title: "Gadget", image: "data-category-4", color: "#F1EDFC")
        ]
        let featuredProducts: [Product]  = [
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86),
            .init(image: "data-product-1", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86),
            .init(image: "data-product-2", name: "TMA-2 HeadPhone", price: "2100", review: 4.0, reviewCount: 120),
            .init(image: "data-product-3", name: "TMA-2 HD Wireless", price: "1500", review: 4.6, reviewCount: 86)
        ]
        let offers: [Offer] = [
            .init(title: "C02 - Cable Multifuntion", image: "data-product-1", color: "#0ACF83")
        ]
        let anotherOffers: [Offer] = [
            .init(title: "Modular Headphone", image: "data-product-2", color: "#3669C9")
        ]
        let news: [News] = [
            .init(titel: "Philosophy That Addresses Topics Such As Goodness",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-1"),
            .init(titel: "Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense",
                  subtitle: "In one general sense, philosophy is ass...",
                  date: "13 Jan 2021", image: "data-news-2"),
            .init(titel: "Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam",
                  subtitle: "Agar tetap kinclong, bodi motor ten...",
                  date: "13 Jan 2021", image: "data-news-3")
        ]
        //
        let addsSection = Section(type: .adds, title: nil, adds: adds)
        let categoriesSection = Section(type: .categories, title: "Categories", categories: categories)
        let featuredProductsSection = Section(type: .products, title: "Featured Product", products: featuredProducts)
        let offersSection = Section(type: .offers, offers: offers)
        let bestSellerProductsSection = Section(type: .products, title: "Best Sellers", products: featuredProducts.shuffled())
        let anotherOffersSection = Section(type: .offers, offers: anotherOffers)
        let newArivalProductsSection = Section(type: .products, title: "New Arrivals", products: featuredProducts.shuffled())
        let topRatedProductsSection = Section(type: .products, title: "Top Rated Product", products: featuredProducts.shuffled())
        let specialProductsSection = Section(type: .products, title: "Special Offers", products: featuredProducts.shuffled())
        let newsSection = Section(type: .news, title: "Latest News", news: news)
        //
        let home = Home(sections: [
            addsSection,
            categoriesSection,
            featuredProductsSection,
            offersSection,
            bestSellerProductsSection,
            anotherOffersSection,
            newArivalProductsSection,
            topRatedProductsSection,
            specialProductsSection,
            newsSection
        ])
        return Just(home).eraseToAnyPublisher()
    }
}
// MARK: Private Handlers
//
private extension HomeViewModel {}

// swiftlint: enable all
