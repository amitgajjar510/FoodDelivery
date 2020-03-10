//
//  MainViewModel.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 10/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func refreshHomeScreen()
    func refreshHomeScreenBanner()
    func error(withMessage message: String)
}

enum MainScreenSections: Int, CaseIterable {
    case VendorType = 0
    case Categories
    case VendorBanner
}

class MainViewModel {
    
    // MARK: - Properties
    var homeScreenData: HomeScreenData?
    var vendorBanners: [VendorBanner] = []
    private lazy var homeScreenWebServiceManager: HomeScreenWebServiceManager = HomeScreenWebServiceManager()
    private lazy var homeScreenBannerWebServiceManager: HomeScreenBannerWebServiceManager = HomeScreenBannerWebServiceManager()
    weak var delegate: MainViewModelDelegate?
    
    // MARK: - Internal Methods
    internal func updateHomeScreen() {
        if homeScreenData == nil {
            fetchHomeScreenData()
        }
        if vendorBanners.count == 0 {
            fetchHomeScreenBanner()
        }
    }
}

extension MainViewModel: WebServiceManagerDelegate {
    // MARK: - API Calls
    private func fetchHomeScreenData() {
        homeScreenWebServiceManager.delegate = self
        homeScreenWebServiceManager.fetchHomeScreenData()
    }
    
    private func fetchHomeScreenBanner() {
        homeScreenBannerWebServiceManager.delegate = self
        homeScreenBannerWebServiceManager.fetchHomeScreenBanner()
    }
    
    // MARK: - WebServiceManagerDelegate Methods
    func responseReceived(asObject object: Any) {
        if let homeScreenData = object as? HomeScreenData {
            self.homeScreenData = homeScreenData
            delegate?.refreshHomeScreen()
        }
        else if let vendorBanners = object as? [VendorBanner] {
            self.vendorBanners = vendorBanners
            delegate?.refreshHomeScreenBanner()
        }
    }
    
    func errorReceived(withString errorString: String) {
        delegate?.error(withMessage: errorString)
    }
}
