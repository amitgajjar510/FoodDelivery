//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Amit Gajjar on 09/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties & Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    private let mainViewModel: MainViewModel = MainViewModel()
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewModel.updateHomeScreen()
    }
    
    // MARK: - Private Methods
    private func initializeView() {
        mainViewModel.delegate = self
    }
}

extension MainViewController: MainViewModelDelegate {
    
    // MARK: - MainViewModelDelegate Methods
    func refreshHomeScreen() {
        DispatchQueue.main.async { [unowned self] in
            self.mainCollectionView.reloadData()
        }
    }
    
    func refreshHomeScreenBanner() {
        DispatchQueue.main.async { [unowned self] in
            self.mainCollectionView.reloadData()
        }
    }
    
    func error(withMessage message: String) {
        print(message)
    }
}

extension MainViewController: UICollectionViewDataSource {
     // MARK: - UICollectionViewDataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
