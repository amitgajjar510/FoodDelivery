//
//  VendorType.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class VendorType: Codable {
    
    // MARK: - Properties
    var vendorTypeId: String?
    var name: String?
    var appImage: String?

    // MARK: - Coding Keys enumerator
    private enum CodingKeys: String, CodingKey {
        case vendorTypeId = "id"
        case name = "name"
        case appImage = "app_image"
    }
}
