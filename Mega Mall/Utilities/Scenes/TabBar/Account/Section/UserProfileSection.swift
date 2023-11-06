//
//  UserProfileSection.swift
//  Lepgo
//
//  Created by Ahmed Yamany on 03/09/2023.
//

import UIKit
import CompositionalLayoutableSection

class UserProfileCollectionViewSection: CompositionalLayoutableSection {
    typealias ResposeType = AccountModel
    var items: [ResposeType] = []
    override init() {
        super.init()
        self.delegate = self
        self.dataSource = self
        self.layout = self
    }
}

extension UserProfileCollectionViewSection: CompositionalLayoutableSectionDataSource {
    var cellType: UserProfileCell.Type { UserProfileCell.self }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType, for: indexPath)
        cell.update(with: items[indexPath.row])
        return cell
    }
    func update(_ collectionView: UICollectionView, withItems items: [ResposeType]) {
        self.items = items
    }
}

extension UserProfileCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 12 }
    var height: CGFloat { 52 }
    var itemLayoutInGroup: NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    var groupLayoutInSection: NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayoutInGroup])
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
        return group
    }
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
        return section
    }
}

extension UserProfileCollectionViewSection: CompositionalLayoutableSectionDelegate {
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(cellType)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        items[indexPath.row].action()
    }
}
