//
//  VendorBannerCollectionCell.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class VendorBannerCollectionCell: UICollectionViewCell {

    // MARK: - Properties & Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerImageView.layer.cornerRadius = 20.0
    }
    
    // MARK: - Internal Methods
    internal func fillCellData(forTag tag: Int, vendorBanner: VendorBanner) {
        self.tag = tag
        bannerImageView.image = nil
        DispatchQueue.global(qos: .background).async { [unowned self] in
            guard let url = URL(string: vendorBanner.image ?? StringConstants.empty), let imageData = try? Data(contentsOf: url)
                else {
                    return
            }
            DispatchQueue.main.async { [unowned self] in
                self.bannerImageView.image = UIImage(data: imageData)
            }
        }
        
    }

}
