//
//  CompositionalLayoutDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

@available(iOS 13.0, *)
open class CompositionalLayoutDelegate: NSObject, UICollectionViewDelegate {
    open var provider: (any CompositionalLayoutProvider)?
    open var lastScolleOffset: CGFloat = 0
    public func updateProvider(with provider: any CompositionalLayoutProvider ) {
        self.provider = provider
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = self.provider?.getCompositionalLayoutableSection(at: indexPath)
        section?.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
