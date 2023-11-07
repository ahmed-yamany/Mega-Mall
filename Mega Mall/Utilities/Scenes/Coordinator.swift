//
//  Coordinator.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 06/11/2023.
//

import UIKit
import Factory

final class Coordinator: SharedContainer {
    static var shared: Coordinator = Coordinator()
    var manager: ContainerManager = .init()
    ///
    private init() {}
}

// MARK: - TabBar
extension Coordinator {
    var tabbar: ParameterFactory<TabBarViewModel, UITabBarController> {
        self { TabBarViewController(viewModel: $0) }
    }
}
// MARK: - Onboarding
extension Coordinator {
    var login: Factory<UINavigationController> {
        self { MegaNavigationController(rootViewController: LoginViewController()) }
    }
    //
    var verification: ParameterFactory<VerificationViewModel, UIViewController> {
        self { VerificationViewController(viewModel: $0) }
    }
    //
    var forgotPassword: Factory<UIViewController> {
        self { ResetPasswordViewController() }
    }
    //
    var updatePassword: Factory<UIViewController> {
        self { UpdatePasswordViewController() }
    }
    //
    var register: Factory<UIViewController> {
        self { RegisterViewController() }
    }
    //
    var profileUpdate: Factory<UIViewController> {
        self { ProfileUpdateViewController() }
    }
}
// MARK: - TabBar
extension Coordinator {
    var home: Factory<UINavigationController> {
        self { MegaNavigationController(rootViewController: HomeViewController()) }
            .shared
    }
    //
    var wishlist: Factory<UINavigationController> {
        self { MegaNavigationController(rootViewController: WishListViewController()) }
            .shared
    }
    //
    var order: Factory<UINavigationController> {
        self { MegaNavigationController(rootViewController: OrderViewController()) }
            .shared
    }
    //
    var account: Factory<UINavigationController> {
        self { MegaNavigationController(rootViewController: AccountViewController()) }
            .shared
    }
}
// MARK: - Home
extension Coordinator {
    var category: ParameterFactory<Category, UIViewController> {
        self { category in
            let categoryViewModel = CategoryViewModel(category: category)
            return CategoryViewController(viewModel: categoryViewModel)
        }
    }
    //
    var product: ParameterFactory<Product, UIViewController> {
        self { product in
            let productDetailViewModel = ProductDetailsViewModel(product: product)
            return ProductDetailsViewController(viewModel: productDetailViewModel)
        }
    }
    //
    var newsDetail: ParameterFactory<News, UIViewController> {
        self { news in
            let viewModel = DetailNewsViewModel(news: news)
            return DetailNewsViewController(viewModel: viewModel)
        }
    }
    //
    var allNews: Factory<UIViewController> {
        self { AllNewsViewController() }
    }
    //
    var store: ParameterFactory<Store, UIViewController> {
        self { store in
            let viewModel = StoreViewModel(store: store)
            return StoreViewController(viewModel: viewModel)
        }
    }
}
