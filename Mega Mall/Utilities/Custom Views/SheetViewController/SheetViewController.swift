//
//  AlertViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit

class SheetViewController: UIViewController {
    // MARK: - Outlets
    //
    @IBOutlet weak private(set) var titleLabel: H3Label!
    @IBOutlet weak private(set) var stackView: UIStackView!
    // MARK: - Properties
    //
    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
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
    //
    public func present(completion: @escaping () -> Void = {}) {
        guard let topMostController =  UIApplication.shared.topMostViewController() else {
            Logger.log("Failed to get UIWindiow top most controller", category: \.onboarding, level: .fault)
            return
        }
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
        }
        //
        topMostController.present(self, animated: true, completion: completion)
    }
    public func addChild(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
// MARK: - Actions
//
extension SheetViewController {
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
