//
//  ViewModel Container.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 21/10/2023.
//

import Factory

final class ViewModelContainer: SharedContainer {
    static var shared: ViewModelContainer = .init()
    var manager: ContainerManager = .init()
}
// MARK: - Onboarding
extension ViewModelContainer {
    var login: Factory<LoginViewModel> {
        self { LoginViewModel() }
    }
}
