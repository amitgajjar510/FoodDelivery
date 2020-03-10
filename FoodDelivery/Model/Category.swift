//
//  Category.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class Category: Codable {
    
    // MARK: - Properties
    var categoryId: String?
    var name: String?
    var image: String?

    // MARK: - Coding Keys enumerator
    private enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case name = "name"
        case image = "image"
    }
}
