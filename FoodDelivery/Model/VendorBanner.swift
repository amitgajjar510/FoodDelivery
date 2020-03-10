//
//  VendorBanner.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class VendorBanner: Codable {
    
    // MARK: - Properties
    var vendorBannerId: String?
    var image: String?
    var height: String?
    var width: String?

    // MARK: - Coding Keys enumerator
    private enum CodingKeys: String, CodingKey {
        case vendorBannerId = "id"
        case image = "image"
        case height = "height"
        case width = "width"
    }
}
