//
//  MainCollectionReusableView.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class MainCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties & Outlets
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - View Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.systemGroupedBackground
    }
    
    // MARK: - Internal Methods
    internal func fillReusableViewData(forSection section: Int, headerTitle: String) {
        self.tag = section
        headerLabel.text = headerTitle
    }
    
}
