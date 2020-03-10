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
    private let mainViewModel: MainViewModel = MainViewModel()
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewModel.updateHomeScreen()
    }
    
    // MARK: - Private Methods
    private func initializeView() {
        mainViewModel.delegate = self
        
        mainCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StringConstants.ReuseIdentifiers.CollectionViewCell.rawValue)
        mainCollectionView.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: StringConstants.ReuseIdentifiers.CategoryCollectionCell.rawValue)
        mainCollectionView.register(UINib(nibName: "MainCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StringConstants.ReuseIdentifiers.MainCollectionReusableView.rawValue)
    }
}

extension MainViewController: MainViewModelDelegate {
    
    // MARK: - MainViewModelDelegate Methods
    func refreshHomeScreen() {
        DispatchQueue.main.async { [unowned self] in
            self.mainCollectionView.reloadData()
        }
    }
    
    func refreshHomeScreenBanner() {
        DispatchQueue.main.async { [unowned self] in
            self.mainCollectionView.reloadData()
        }
    }
    
    func error(withMessage message: String) {
        print(message)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     // MARK: - UICollectionViewDataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MainScreenSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems: Int = 0
        switch section {
        case MainScreenSections.VendorType.rawValue:
            numberOfItems = 1
        case MainScreenSections.Categories.rawValue:
            numberOfItems = mainViewModel.homeScreenData?.categories.count ?? 0
        case MainScreenSections.VendorBanner.rawValue:
            numberOfItems = 1
        default: break
        }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionViewCell = UICollectionViewCell()
        switch indexPath.section {
        case MainScreenSections.VendorType.rawValue:
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.ReuseIdentifiers.CollectionViewCell.rawValue, for: indexPath)
            if let vendorTypes: [VendorType] = mainViewModel.homeScreenData?.vendorTypes {
                (collectionViewCell as? CollectionViewCell)?.fillCellData(forTag: indexPath.section, cellData: vendorTypes)
            }
        case MainScreenSections.Categories.rawValue:
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.ReuseIdentifiers.CategoryCollectionCell.rawValue, for: indexPath)
            if let category: Category = mainViewModel.homeScreenData?.categories[indexPath.item] {
                (collectionViewCell as? CategoryCollectionCell)?.fillCellData(forTag: indexPath.item, category: category)
            }
        case MainScreenSections.VendorBanner.rawValue:
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.ReuseIdentifiers.CollectionViewCell.rawValue, for: indexPath)
            (collectionViewCell as? CollectionViewCell)?.fillCellData(forTag: indexPath.section, cellData: mainViewModel.vendorBanners)
        default: break
        }
        return collectionViewCell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize.zero
        switch indexPath.section {
        case MainScreenSections.VendorType.rawValue, MainScreenSections.VendorBanner.rawValue:
            size = CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenWidth / 2)
        case MainScreenSections.Categories.rawValue:
            size = CGSize(width: SizeConstants.screenWidth / 3, height: SizeConstants.screenWidth / 3)
        default: break
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var size: CGSize = CGSize.zero
        switch section {
        case MainScreenSections.VendorBanner.rawValue:
            size = CGSize(width: SizeConstants.screenWidth, height: 40.0)
        default: break
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StringConstants.ReuseIdentifiers.MainCollectionReusableView.rawValue, for: indexPath)
        if indexPath.section == MainScreenSections.VendorBanner.rawValue {
            (reusableView as? MainCollectionReusableView)?.fillReusableViewData(forSection: indexPath.section, headerTitle: "- More from Foodhall -")
        }
        return reusableView
    }
}
