//
//  HomeScreenBannerWebServiceManager.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class HomeScreenBannerWebServiceManager: WebServiceManager {
    
    // MARK: - HomeScreenBannerWebServiceManager Methods
    func fetchHomeScreenBanner() {
        jsonData(forURLString: URLConstants.fetchHomeScreenBanner, andMethod: .Get)
    }
    
    // MARK: - Parent class implementation methods
    override func parseData(withData data: Data) {
        do {
            guard let jsonResponseDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any], let mainContentDictionary = jsonResponseDictionary["main_content"] as? [String: Any], let itemResponseDictionary = mainContentDictionary["item"] as? [String: Any]
                else {
                    parseError(withString: ErrorConstants.responseMismatched)
                    return
            }
            var vendorBanners: [VendorBanner] = []
            if let vendorBannerResponseArray = itemResponseDictionary["data"] as? [[String: Any]] {
                let vendorBannerResponseData: Data = try JSONSerialization.data(withJSONObject: vendorBannerResponseArray, options: .prettyPrinted)
                vendorBanners = try JSONDecoder().decode([VendorBanner] .self, from: vendorBannerResponseData)
            }
            delegate?.responseReceived(asObject: vendorBanners)
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
