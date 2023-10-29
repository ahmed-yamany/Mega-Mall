//
//  CategoriesViewController.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import UIKit
import MakeConstraints

class CategoriesViewController: SheetViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Categories"
        addChild(collectionView)
        collectionView.heightConstraints(200)
        collectionView.backgroundColor = .blue
    }
}
