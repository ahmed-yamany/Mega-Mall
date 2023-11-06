//
//  AlertViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit
import Extensions

class SheetViewController: UIViewController {
    // MARK: - Outlets
    /// The title label at the top of the sheet.
    @IBOutlet weak private(set) var titleLabel: H3Label!
    /// The stack view that holds the content within the sheet.
    @IBOutlet weak private(set) var stackView: UIStackView!
    // MARK: - Properties
    //
    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    // Initializes a new instance of `SheetViewController`.
    init() {
        super.init(nibName: "SheetViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /// Presents the sheet view controller on top of the current view hierarchy.
    public func presentSheet(completion: @escaping () -> Void = {}) {
        // Get the top-most view controller in the application's window.
        guard let topMostController =  UIApplication.shared.topMostViewController() else {
            Logger.log("Failed to get UIWindow top most controller", category: \.onboarding, level: .fault)
            return
        }
        //
        modalPresentationStyle = .overFullScreen
        // Present the sheet view controller.
        topMostController.present(self, animated: true, completion: completion)
    }
    /// Adds a child view to the stack view within the sheet.
    ///
    /// - Parameter view: The view to be added to the stack.
    public func addChild(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
// MARK: - Actions
//
extension SheetViewController {
    /// Action method for dismissing the sheet view controller.
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
