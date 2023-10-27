//
//  MegaCollectionReusableView.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit

class MegaCollectionReusableView: UICollectionReusableView {
    // MARK: IBOutlet
    //
    @IBOutlet weak var label: H3Label!
    @IBOutlet weak var button: LabelButton!
    // MARK: Properities
    var viewModel: ViewModel? {
        didSet {
            label.text = viewModel?.label
            button.setTitle(viewModel?.button, for: .normal)
        }
    }
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
    /// Loads the view from a nib file and adds it as a subview to the MegaCollectionReusableView view.
    private func loadNib() {
        // Please do not update this code, as it's used to load the view from a nib.
        // swiftlint:disable all
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
        // swiftlint:enable all
    }
    @IBAction func buttonTapped(_ sender: LabelButton) {
        viewModel?.action?()
    }
}
// MARK: - ViewModel
//
extension MegaCollectionReusableView {
    /// The ViewModel structure for MegaCollectionReusableView.
    ///  It represents the data required to display information in the user interface.
    struct ViewModel {
        let label: String
        var button: String?
        var action: (() -> Void)?
    }
}
// MARK: - Configurations
//
extension MegaCollectionReusableView {
    /// Configures the MegaCollectionReusableView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: MegaCollectionReusableView.ViewModel) {
        self.viewModel = viewModel
    }
}
