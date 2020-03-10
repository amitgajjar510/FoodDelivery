//
//  HomeScreenWebServiceManager.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class HomeScreenWebServiceManager: WebServiceManager {
    // MARK: - HomeScreenWebServiceManager Methods
    func fetchHomeScreenData() {
        jsonData(forURLString: URLConstants.fetchHomeScreenData, andMethod: .Get)
    }
    
    // MARK: - Parent class implementation methods
    override func parseData(withData data: Data) {
        do {
            guard let jsonResponseDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any], let mainContentDictionary = jsonResponseDictionary["main_content"] as? [String: Any], let dataResponseArray = mainContentDictionary["data"] as? [[String: Any]]
                else {
                    parseError(withString: ErrorConstants.responseMismatched)
                    return
            }
            let homeScreenData: HomeScreenData = HomeScreenData()
            for (index, data) in dataResponseArray.enumerated() {
                if index == 0 {
                    if let categoriesResponseDictionary = data["category"] as? [[String: Any]] {
                        let categoriesResponseData: Data = try JSONSerialization.data(withJSONObject: categoriesResponseDictionary, options: .prettyPrinted)
                        let categories = try JSONDecoder().decode([Category] .self, from: categoriesResponseData)
                        homeScreenData.categories = categories
                    }
                }
                else if index == 1 {
                    if let vendorTypeResponseDictionary = data["vendor_type_details"] as? [[String: Any]] {
                        let vendorTypeResponseData: Data = try JSONSerialization.data(withJSONObject: vendorTypeResponseDictionary, options: .prettyPrinted)
                        let vendorTypes = try JSONDecoder().decode([VendorType] .self, from: vendorTypeResponseData)
                        homeScreenData.vendorTypes = vendorTypes
                    }
                }
            }
            delegate?.responseReceived(asObject: homeScreenData)
        }
        catch let error {
            print(error.localizedDescription)
            parseError(withString: error.localizedDescription)
        }
    }

    override func parseError(withString errorString: String) {
        delegate?.errorReceived(withString: errorString)
    }
}
