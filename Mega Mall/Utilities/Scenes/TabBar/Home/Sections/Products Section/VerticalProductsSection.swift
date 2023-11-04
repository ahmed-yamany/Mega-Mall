//
//  VerticalProductsCollectionViewSection.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 02/11/2023.
//

import UIKit
import CompositionalLayoutableSection
import ViewAnimator

// A custom section for displaying Products in a collection view.
class VerticalProductsCollectionViewSection: ProductsCollectionViewSection {
    override var itemLayoutInGroup: NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    override func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Define the size for a group in the collection view section
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        //
        // Create a horizontal group that contains items with the specified layout
        let group: NSCollectionLayoutGroup
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: itemLayoutInGroup, count: 2)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayoutInGroup, count: 2)
        }
        //
        // Calculate available empty space to adjust items
        let sectionWidth = layoutEnvironment.container.effectiveContentSize.width
        let itemsWidth = width * 2 // two items per group
        let emptyWidth = sectionWidth - itemsWidth
        let padding = emptyWidth / 3 // leading trailing interItemSpacing
        //
        // Set the spacing between items in the group
        group.interItemSpacing = .fixed(padding)
        //
        // Create the collection view section with the defined group
        let section = NSCollectionLayoutSection(group: group)
        ///
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: padding, bottom: spacing, trailing: padding)
        ///
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = spacing
        ///
        var supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
        ///
        if topViewModel != nil {
            supplementaryItems.append(topSupplementaryItem)
        }
        ///
        if bottomViewModel != nil {
            supplementaryItems.append(bottomSupplementaryItem)
        }
        section.boundarySupplementaryItems = supplementaryItems
        ///
        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: DecorationViewType.identifier)
        section.decorationItems = [sectionBackground]
        ///
        return section
    }
}
