//
//  CompositionalLayoutDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

@available(iOS 13.0, *)
open class CompositionalLayoutDelegate: NSObject, UICollectionViewDelegate {
    public var provider: (any CompositionalLayoutProvider)!
    ///
    public init(provider: any CompositionalLayoutProvider) {
        self.provider = provider
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, shouldHighlightItemAt: indexPath) ?? true
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didHighlightItemAt: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, shouldSelectItemAt: indexPath) ?? true
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, shouldDeselectItemAt: indexPath) ?? true
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    // swiftlint: disable all
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, canPerformPrimaryActionForItemAt indexPath: IndexPath) -> Bool { 
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, canPerformPrimaryActionForItemAt: indexPath) ?? true
    }
    ///
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, performPrimaryActionForItemAt indexPath: IndexPath) { 
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, performPrimaryActionForItemAt: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)
    }
    ///
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, contextMenuConfigurationForItemAt: indexPath, point: point)
    }
    ///
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPaths.first!)
        return section.delegate?.collectionView?(collectionView, contextMenuConfigurationForItemsAt: indexPaths, point: point)
    }
    ///
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, dismissalPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, contextMenuConfiguration: configuration, dismissalPreviewForItemAt: indexPath)
    }
    ///
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, highlightPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
        let section = self.provider.getCompositionalLayoutableSection(at: indexPath)
        return section.delegate?.collectionView?(collectionView, contextMenuConfiguration: configuration, highlightPreviewForItemAt: indexPath)
    }
    // swiftlint: enable all
}
