//
//  AFVMainScreenViewController.swift
//  AppForVitsolutions
//
//  Created by Ivashin Dmitry on 4/3/17.
//  Copyright © 2017 Ivashin Dmitry. All rights reserved.
//

import UIKit
import PKHUD

class AFVMainScreenViewController: UICollectionViewController {
    
    enum SegueIdentifier: String {
        case imageGenerator = "AFVSegueToImageGenerator"
    }
    
    enum ReuseIdentifier: String {
        case weatherCell = "AFVWeatherCell"
    }
    
    let applicationManager = AFVApplicationManager.instance()
    
    var data = [AFVWeather]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllWeatherEntities()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        data.removeAll()
    }
    
    private func getAllWeatherEntities()
    {
        HUD.show(.progress)
        applicationManager.apiService.getAll { (result) in
            switch result {
            case .success(let value):
                HUD.flash(.success)
                guard let dictionary = value as? [String: Any], let array = dictionary["images"] as? [[String: Any]] else { return }
                self.data.removeAll()
                for dictionary in array {
                    let weatherEntity = AFVWeather(with: dictionary)
                    self.data.append(weatherEntity)
                }
            case .failure(let error):
                HUD.flash(.error)
                print(error)
            }
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.weatherCell.rawValue, for: indexPath) as! AFVWeatherViewCell
        cell.weather = data[indexPath.row]
        return cell
    }

}
