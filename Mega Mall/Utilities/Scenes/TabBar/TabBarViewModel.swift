//
//  TabBarViewModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import UIKit
import Combine
import ViewAnimator

enum TabBarItems: Int {
    case home = 0
    case wishlist, order, account
}

class TabBarViewModel: ObservableObject {
    static let shared = TabBarViewModel()
    @Published var selectedItem: TabBarItems = .home
    @Published var isLogin: Bool = false
    @Published var animationConfigurations = AnimatableTabBarConfigurations()
    var cancellableSet: Set<AnyCancellable> = .init()
    private init() {
        animationConfigurations.animationScope = .image
        animationConfigurations.animatenWhileSelected = true
    }
}
