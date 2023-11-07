//
//  TabBarViewModel.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import UIKit
import Combine
import ViewAnimator
import Extensions

enum TabBarItems: Int {
    case home = 0
    case wishlist, order, account
}

class TabBarViewModel: ObservableObject {
    static let shared = TabBarViewModel()
    ///
    @UserDefault<Bool>(key: \.login) var login
    ///
    @Published var selectedItem: TabBarItems = .home
    @Published var tabBarIsHidden: Bool = false
    @Published var isLogin: Bool = false
    @Published var cart: [Product] = []
    @Published var orders: [Order] = []
    @Published var whishies: [Product] = []
    @Published var notifications: [Notification] = [.init(isRead: false)]
    //
    var cancellableSet: Set<AnyCancellable> = .init()
    //
    private init() {
    }
    ///
    func logout() {
        selectedItem = .home
        isLogin = false
        login = false
        cart.removeAll()
        orders.removeAll()
        whishies.removeAll()
        notifications.removeAll()
    }
}
