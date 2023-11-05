//
//  ProductAvailabilityView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit
import Extensions

class ProductAvailabilityView: UIView {
    // MARK: IBOutlet
    //
    @IBOutlet weak var label: RegularLabel!
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
    /// Loads the view from a nib file and adds it as a subview to the ProductAvailabilityView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
}
// MARK: - ViewModel
//
extension ProductAvailabilityView {
    /// The ViewModel structure for ProductAvailabilityView.
    ///  It represents the data required to display information in the user interface.
    struct ViewModel {
        let availableCount: Int
    }
}
// MARK: - Configurations
//
extension ProductAvailabilityView {
    /// Configures the ProductAvailabilityView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: ProductAvailabilityView.ViewModel) {
        layerCornerRadius = frame.height / 6
        if viewModel.availableCount > 0 {
            backgroundColor = .megaLightGreen
            label.textColor = .megaSecondaryEarthGreen
            label.text = "Available \(viewModel.availableCount)"
        } else {
            backgroundColor = .megaLightRed
            label.textColor = .megaSecondaryRedVelvet
            label.text = "unAvailable"
        }
    }
}
