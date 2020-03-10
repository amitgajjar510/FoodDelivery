//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 09/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties & Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: UICollectionViewDataSource {
     // MARK: - UICollectionViewDataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
