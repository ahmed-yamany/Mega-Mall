//
//  AnimatableTabBarConfigurations.swift
//
//  Created by Ahmed Yamany on 25/10/2023.
//

import Foundation
import Combine

@available(iOS 13.0, *)
/// A configuration class for customizing the behavior of the `AnimatableTabBarController`.
open class AnimatableTabBarConfigurations {
    /// Enum representing the scope of animation for tab bar items.
    public enum AnimationScope {
        case all, image, title
    }
    /// A flag indicating whether tab bar items are animatable.
    @Published public var animatable: Bool = true
    /// The scope of animation for tab bar items.
    @Published public var animationScope: AnimationScope = .all
    /// A flag indicating whether animations should occur while an item is selected.
    @Published public var animatenWhileSelected: Bool = false
    /// Initializes a new instance of `AnimatableTabBarConfigurations`.
    public init() { }
}
