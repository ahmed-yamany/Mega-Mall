//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import CompositionalLayoutableSection

class ProductDetailCollectionViewCell: UICollectionViewCell, CompositionalLayoutProvider {
    // MARK: Outlets
    //
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    ///
    @IBOutlet weak var nameLabel: H1Label!
    @IBOutlet weak var priceLabel: H3Label!
    @IBOutlet weak var reviewLabel: SmallLabel!
    @IBOutlet weak var reviewCountLabel: RegularLabel!
    @IBOutlet weak var availabilityView: ProductAvailabilityView!
    @IBOutlet weak var storeView: ProductStoreView!
    @IBOutlet weak var descriptionLabel: RegularLabel!
    // MARK: - Properties
    //
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    // MARK: - Lifecycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        imagesCollectionView.delegate = delegate
        imagesCollectionView.dataSource = dataSource
    }
    public func configure(with product: Product) {
        configureImages(for: product)
        nameLabel.text = product.name
        priceLabel.text = "RP \( product.price)"
        reviewLabel.text = "\(product.review)"
        reviewCountLabel.text = "\(product.reviewCount) Reviews"
        availabilityView.configure(with: .init(availableCount: product.availableCount))
        ///
        storeView.configure(with: product.store)
        ///
        descriptionLabel.text = product.description
    }
}

// MARK: - Configurations
private extension ProductDetailCollectionViewCell {
    func configureImages(for product: Product) {
        let section = ProductImagesCollectionViewSection()
        section.update(imagesCollectionView, withItems: [UIImage(named: product.image),
                                                         UIImage(named: product.image)])
        compositionalLayoutSections.append(section)
        imagesCollectionView.updateCollectionViewCompositionalLayout(for: self)
    }
}
