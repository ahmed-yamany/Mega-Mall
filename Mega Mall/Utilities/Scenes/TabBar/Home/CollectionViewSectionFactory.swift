//
//  CollectionViewSectionFactory.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 18/01/2024.
//

import UIKit
import Extensions
import CompositionalLayoutableSection

protocol SectionFactory {
    var viewController: UIViewController { get set }
    init(viewController: UIViewController)
    func createSection(from section: Section, owner viewController: UIViewController) -> CompositionalLayoutableSection
}

class AddsSectionFactory: SectionFactory {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func createSection(from section: Section, owner viewController: UIViewController) -> CompositionalLayoutableSection {
        let collectionViewSection = AddsCollectionViewSection()
        if let adds = section.adds {
            collectionViewSection.items = adds
        } else {
            Logger.log("could not wrap Adds this may be an error from the backend", category: \.home, level: .fault)
        }
        return collectionViewSection
    }
}

class CategoriesSectionFactory: SectionFactory {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func createSection(from section: Section, owner viewController: UIViewController) -> CompositionalLayoutableSection {
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
}

class ProductsSectionFactory: SectionFactory {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func createSection(from section: Section, owner viewController: UIViewController) -> CompositionalLayoutableSection {
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
}

class OffersSectionFactory: SectionFactory {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func createSection(from section: Section, owner viewController: UIViewController) -> CompositionalLayoutableSection {
        let collectionViewSection = OfferCollectionViewSection()
        
        if let offers = section.offers {
            collectionViewSection.items = offers
        } else {
            Logger.log("could not wrap Offers this may be an error from the backend", category: \.home, level: .fault)
        }
        return collectionViewSection
    }
}

class NewsSectionFactory: SectionFactory {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func createSection(from section: Section, owner viewController: UIViewController) -> CompositionalLayoutableSection {
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

class CollectionViewSectionFactory {
    private lazy var addsSection: SectionFactory = AddsSectionFactory(viewController: viewController)
    private lazy var categoriesSection: SectionFactory = CategoriesSectionFactory(viewController: viewController)
    private lazy var productsSection: SectionFactory = ProductsSectionFactory(viewController: viewController)
    private lazy var offersSection: SectionFactory = OffersSectionFactory(viewController: viewController)
    private lazy var newsSection: SectionFactory = NewsSectionFactory(viewController: viewController)
    
    let viewController: UIViewController
    init(owner viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func makeCompositionalLayoutableSection(from section: Section) -> CompositionalLayoutableSection {
        switch section.type {
            case .adds: return addsSection.createSection(from: section, owner: viewController)
            case .categories: return categoriesSection.createSection(from: section, owner: viewController)
            case .products: return productsSection.createSection(from: section, owner: viewController)
            case .offers: return offersSection.createSection(from: section, owner: viewController)
            case .news: return newsSection.createSection(from: section, owner: viewController)
        }
    }
}
