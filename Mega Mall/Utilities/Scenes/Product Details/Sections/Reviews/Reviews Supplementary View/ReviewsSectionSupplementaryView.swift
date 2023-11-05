//
//  ReviewsSectionSupplementaryView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit

class ReviewsSectionSupplementaryView: UICollectionReusableView {
    // MARK: IBOutlet
    //
    @IBOutlet weak var reviewCountLabel: H3Label!
    @IBOutlet weak var rateLabel: H3Label!
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    /// Loads the view from a nib file and adds it as a subview to the ReviewsSectionSupplementaryView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
}

// MARK: - Configurations
//
extension ReviewsSectionSupplementaryView {
    /// Configures the ReviewsSectionSupplementaryView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with product: Product) {
        reviewCountLabel.text = "Review (\(product.reviewCount))"
        rateLabel.text = "\(product.review)"
    }
}
