//
//  CollectionViewCell.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: - Properties & Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var cellData: [Any] = []
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "VendorTypeCollectionCell", bundle: nil), forCellWithReuseIdentifier: StringConstants.ReuseIdentifiers.VendorTypeCollectionCell.rawValue)
        collectionView.register(UINib(nibName: "VendorBannerCollectionCell", bundle: nil), forCellWithReuseIdentifier: StringConstants.ReuseIdentifiers.VendorBannerCollectionCell.rawValue)
    }
    
    // MARK: - Internal Methods
    internal func fillCellData(forTag tag: Int, cellData: [Any]) {
        self.tag = tag
        self.cellData = cellData
        collectionView.reloadData()
        switch tag {
        case MainScreenSections.VendorType.rawValue:
            collectionView.isPagingEnabled = true
        case MainScreenSections.VendorBanner.rawValue:
            collectionView.backgroundColor = UIColor.systemGroupedBackground
        default: break
        }
    }
}

extension CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionViewCell = UICollectionViewCell()
        switch tag {
        case MainScreenSections.VendorType.rawValue:
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.ReuseIdentifiers.VendorTypeCollectionCell.rawValue, for: indexPath)
            if let vendorType: VendorType = (cellData as? [VendorType])?[indexPath.item] {
                (collectionViewCell as? VendorTypeCollectionCell)?.fillCellData(forTag: indexPath.item, vendorType: vendorType)
            }
        case MainScreenSections.VendorBanner.rawValue:
            collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.ReuseIdentifiers.VendorBannerCollectionCell.rawValue, for: indexPath)
            if let vendorBanner: VendorBanner = (cellData as? [VendorBanner])?[indexPath.item] {
                (collectionViewCell as? VendorBannerCollectionCell)?.fillCellData(forTag: indexPath.item, vendorBanner: vendorBanner)
            }
        default: break
        }
        return collectionViewCell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize.zero
        switch tag {
        case MainScreenSections.VendorType.rawValue:
            size = CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenWidth / 2)
        case MainScreenSections.VendorBanner.rawValue:
            let width: CGFloat = SizeConstants.screenWidth - 50.0
            size = CGSize(width: width, height: width / 2)
        default: break
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        switch tag {
        case MainScreenSections.VendorBanner.rawValue:
            edgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        default: break
        }
        return edgeInsets
    }
}
