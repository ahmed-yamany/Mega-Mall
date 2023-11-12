//
//  CustomSegmentControl.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 04/11/2023.
//

import UIKit
import Combine

@objc public protocol SegmentControlDelegate: NSObjectProtocol {
    /// Notifies the delegate when a selected button is updated.
    @objc optional func segmentControl(_ segmentControl: CustomSegmetedControl, updateSelected button: UIButton)
    /// Notifies the delegate when an unselected button is updated.
    @objc optional func segmentControl(_ segmentControl: CustomSegmetedControl, updateUnSelected button: UIButton)
    /// Notifies the delegate when a segment is selected at a specific index.
    @objc optional func segmentControl(_ segmentControl: CustomSegmetedControl, didSelectSegmentAt index: Int)
}

/// A custom segmented control that allows switching between segments with visual customization options.
open class CustomSegmetedControl: UIView {
    /// The container for holding the buttons.
    private var buttonsContainer: UIStackView = UIStackView()
    /// The array of buttons in the segmented control.
    private var buttons: [UIButton] = []
    /// The titles for each segment in the segmented control.
    private var buttonTitles: [String] = []
    /// The view representing the selection indicator.
    private var barView: UIView = UIView()
    /// The leading constraint for the selection indicator's position.
    private var barViewLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    /// The index of the currently selected button.
    private(set) var selectedButtonIndex: Int = 0
    /// The delegate for handling segmented control events.
    open weak var delegate: SegmentControlDelegate?
    //
    /// Creates the custom segmented control with segments having the given titles.
    /// - Parameters:
    ///   - buttonTitles: The titles of the segmented control will have.
    public func configure(buttonTitles: [String]) {
        guard !buttonTitles.isEmpty else { return }
        self.buttonTitles = buttonTitles
        configureUI()
    }
    ///
    private func configureUI() {
        prepareButtons()
        prepareButtonsContainer()
        prepareBarView()
    }

//     Creates the buttons from the buttonTitles array
    private func prepareButtons() {
        buttons = buttonTitles.map { title in
            let button: UIButton = createButton(title: title)
            buttonsContainer.addArrangedSubview(button)
            return button
        }
        delegate?.segmentControl?(self, updateSelected: buttons[0])
        delegate?.segmentControl?(self, didSelectSegmentAt: 0)
    }
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        delegate?.segmentControl?(self, updateUnSelected: button)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }

    //
    // Add the buttons in a horizontal container
    private func prepareButtonsContainer() {
        addSubview(barView)
        addSubview(buttonsContainer)
        buttonsContainer.fillSuperview()
        //
        buttonsContainer.axis = .horizontal
        buttonsContainer.distribution = .fillEqually
        buttonsContainer.spacing = 8
        // add button to buttonsContainer
        buttons.forEach { buttonsContainer.addArrangedSubview($0) }
    }
    ///
    private func prepareBarView() {
        let firstButton = buttons[0]
        barView.translatesAutoresizingMaskIntoConstraints = false
        updateBarView(barView, for: firstButton)
        barViewLeadingConstraint = barView.leadingAnchor.constraint(equalTo: firstButton.leadingAnchor)
        ///
        NSLayoutConstraint.activate([
            barView.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor),
            barView.widthAnchor.constraint(equalTo: firstButton.widthAnchor),
            barView.heightAnchor.constraint(equalToConstant: 2),
            barViewLeadingConstraint
        ])
    }
    //
    // Perform the UI/logic changes when a button is pressed
    @objc private func buttonAction(sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        selectedButtonIndex = buttonIndex
        self.delegate?.segmentControl?(self, didSelectSegmentAt: buttonIndex)
        updateButtonAppearance(at: buttonIndex)
        animateBarViewPosition(to: buttonIndex)
    }
    //
    private func updateButtonAppearance(at index: Int) {
        let selectedButton = buttons[index]
        buttons.forEach { button in
            if button == selectedButton {
                self.delegate?.segmentControl?(self, updateSelected: button)
            } else {
                self.delegate?.segmentControl?(self, updateUnSelected: button)
            }
        }
    }
    //
    // Change and animate the barView position
    private func animateBarViewPosition(to selectedButtonIndex: Int) {
        let selectedButton = buttons[selectedButtonIndex]
        barViewLeadingConstraint.isActive = false
        barViewLeadingConstraint = barView.leadingAnchor.constraint(equalTo: selectedButton.leadingAnchor)
        barViewLeadingConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    func updateBarView(_ barView: UIView, for button: UIButton) {
        barView.backgroundColor = .megaPrimaryBlueOcean
        barView.layer.cornerRadius = 8
    }
}
