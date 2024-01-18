//
//  CollectionViewSectionFactory.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 18/01/2024.
//

import UIKit
import Extensions
import CompositionalLayoutableSection

class CollectionViewSectionFactory {
    let viewController: UIViewController
    init(owner viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func makeCompositionalLayoutableSection(from section: Section) -> CompositionalLayoutableSection {
        switch section.type {
            case .adds: return makeAddsSection(from: section)
            case .categories: return makeCategoriesSection(from: section)
            case .products: return makeProductsSection(from: section)
            case .offers: return makeOffersSection(from: section)
            case .news: return makeNewsSection(from: section)
        }
    }
    
    private func makeAddsSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewSection = AddsCollectionViewSection()
        if let adds = section.adds {
            collectionViewSection.items = adds
        } else {
            Logger.log("could not wrap Adds this may be an error from the backend", category: \.home, level: .fault)
        }
        return collectionViewSection
    }
    
    private func makeCategoriesSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewSection = HomeCategoriesCollectionViewSection()
        
        if let categories = section.categories {
            collectionViewSection.items = categories
        } else {
            Logger.log("could not wrap categories this may be an error from the backend", category: \.home, level: .fault)
        }
        
        if let title = section.title {
            collectionViewSection.configure(owner: viewController, topViewModel: .init(label: title))
        }
        
        return collectionViewSection
    }
    
    private func makeProductsSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewSection = ProductsCollectionViewSection()
        
        if let categories = section.products {
            collectionViewSection.items = categories
        } else {
            Logger.log("could not wrap Products this may be an error from the backend", category: \.home, level: .fault)
        }
        
        if let title = section.title {
            collectionViewSection.configure(owner: viewController,
                                            topViewModel: .init(label: title, button: L10n.App.seeAll, action: { }))
        }
        
        return collectionViewSection
    }
    
    private func makeOffersSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewSection = OfferCollectionViewSection()
        
        if let offers = section.offers {
            collectionViewSection.items = offers
        } else {
            Logger.log("could not wrap Offers this may be an error from the backend", category: \.home, level: .fault)
        }
        return collectionViewSection
    }
    
    private func makeNewsSection(from section: Section) -> CompositionalLayoutableSection {
        let collectionViewSection = NewsCollectionViewSection()
        
        if let news = section.news {
            collectionViewSection.items = news
        } else {
            Logger.log("could not wrap News this may be an error from the backend", category: \.home, level: .fault)
        }
        
        if let title = section.title {
            collectionViewSection.configure(owner: viewController,
                                            topViewModel: .init(label: title),
                                            bottomViewModel: .init(title: "See All News", target: self,
                                                                   action: #selector(newsSectionBottomViewAction(_:))))
        }
        
        return collectionViewSection
    }
    
    @objc private func newsSectionBottomViewAction(_ sender: Any) {
        LoginManager.shared.checkLogin(loginHandler: { [weak self] in
            if let navigationController = self?.viewController.navigationController {
                navigationController.pushViewController(AllNewsViewController(), animated: true)
            } else {
                Logger.log("Failed to Wrap navigationController", category: \.home, level: .fault)
            }
        })
    }
}
