//
//  UserProfileViewController.swift
//  Lepgo
//
//  Created by Ahmed Yamany on 03/09/2023.
//

import UIKit
import CompositionalLayoutableSection
import Extensions

class AccountViewController: UIViewController, CompositionalLayoutProvider {
    // MARK: - @IBOutlet
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    ///
    lazy var delegate = CompositionalLayoutDelegate(provider: self)
    lazy var dataSource = CompositionalLayoutDataSource(provider: self)
    ///
    lazy var userProfileModels: [AccountModel] = [
        AccountModel(icon: .accountUsagePolicy, title: "Usage Policy"),
        AccountModel(icon: .accountSetting, title: "Settings"),
        AccountModel(icon: .accountContactUs, title: "Contact us"),
        AccountModel(icon: .accountLogout, title: "Logout", isNavigatable: false, tintColor: .red, action: logoutAction)
    ]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if TabBarViewModel.shared.isLogin {
            configureViews()
        }
    }
}
// MARK: - Configurations
private extension AccountViewController {
    func configureViews() {
        navigationItem.addTitleLabel(with: "Account", color: .megaPrimaryBlueOcean, font: .h2)
        userProfileImage.makeCircle(withWidth: userProfileImage.frame.width, borderColor: .clear)
        ///
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        ///
        let profileSection = UserProfileCollectionViewSection()
        compositionalLayoutSections = [profileSection]
        profileSection.update(collectionView, withItems: userProfileModels)
        ///
        collectionView.updateCollectionViewCompositionalLayout(for: self)
    }
}
// MARK: - Actions
private extension AccountViewController {
    @IBAction func updateProfileImageButtonDidTapped(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        ///
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        ///
        present(imagePickerVC, animated: true)
    }
    //
    func logoutAction() {
        LogoutViewController().presentSheet()
    }
}
// MARK: - Image picker Delegate
//
extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        ///
        guard let image = info[.originalImage] as? UIImage else {
            Logger.log("failed to cast image from image picker at user profile", category: \.default, level: .fault)
            return
        }
        ///
        userProfileImage.image = image
    }
}
