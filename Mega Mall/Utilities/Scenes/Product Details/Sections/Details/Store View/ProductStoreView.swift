//
//  ProductUserView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 05/11/2023.
//

import UIKit
import Extensions

class ProductStoreView: UIControl {
    // MARK: IBOutlet
    //
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: MediumLabel!
    @IBOutlet weak var subtitle: RegularLabel!
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureViews()
    }
    /// Loads the view from a nib file and adds it as a subview to the ProductUserView view.
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
extension ProductStoreView {
    private func configureViews() {
        imageView.makeCircle(withWidth: 45, borderColor: .clear)
    }
    /// Configures the ProductUserView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with store: Store) {
        nameLabel.text = store.name
        imageView.image = UIImage(named: store.image)
        subtitle.text = store.subtitle
    }
}
