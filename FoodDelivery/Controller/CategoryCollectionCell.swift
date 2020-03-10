//
//  CategoryCollectionCell.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    // MARK: - Properties & Outlets
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Internal Methods
    internal func fillCellData(forTag tag: Int, category: Category) {
        self.tag = tag
        categoryLabel.text = category.name?.uppercased()
        DispatchQueue.global(qos: .background).async { [unowned self] in
            guard let url = URL(string: category.image ?? StringConstants.empty), let imageData = try? Data(contentsOf: url)
                else {
                    return
            }
            DispatchQueue.main.async { [unowned self] in
                if self.tag == tag {
                    self.categoryImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
