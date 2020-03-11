//
//  VendorTypeCollectionCell.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class VendorTypeCollectionCell: UICollectionViewCell {

    // MARK: - Properties & Outlets
    @IBOutlet weak var vendorTypeImageView: UIImageView!
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Internal Methods
    internal func fillCellData(forTag tag: Int, vendorType: VendorType) {
        self.tag = tag
        vendorTypeImageView.image = nil
        DispatchQueue.global(qos: .background).async { [unowned self] in
            guard let url = URL(string: vendorType.appImage ?? StringConstants.empty), let imageData = try? Data(contentsOf: url)
                else {
                    return
            }
            DispatchQueue.main.async { [unowned self] in
                self.vendorTypeImageView.image = UIImage(data: imageData)
            }
        }
    }
}
