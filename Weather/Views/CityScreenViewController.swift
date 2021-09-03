//
//  CityScreenViewController.swift
//  Weather
//
//  Created by Virender Dall on 31/08/21.
//

import UIKit

class CityScreenViewController: UIViewController {
    var selectedCity: BookMarkModel!
    private lazy var viewModel = WeatherViewModel()
    private lazy var  bag: DisposeBag? = DisposeBag()
    
    private let K_CELL_ID = "WeatherInfoCell"
    private let K_COLLECTION_CELL_ID = "TableCellCollectionView"
    private let K_WEATHER_CELL = "WeatherCollectionCell"
    private let k_CELL_HEIGHT: CGFloat = 282
    private let K_SCREEN_SIZE = UIScreen.main.bounds.size
    private let KWIDTH_RATIO: CGFloat = 0.8
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCity.cityName
        tableView.register(UINib(nibName: K_CELL_ID, bundle: nil), forCellReuseIdentifier: K_CELL_ID)
        tableView.register(UINib(nibName: K_COLLECTION_CELL_ID, bundle: nil), forCellReuseIdentifier: K_COLLECTION_CELL_ID)
        
        
        viewModel.cityWeather.bind {[weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: bag)
        
        viewModel.weatherAPIError.bind(listener: showErrorAlert).disposed(by: bag)
        
        viewModel.getWeatherFor(lat: selectedCity.lat, lng: selectedCity.lng)
        NotificationCenter.default.addObserver(self, selector: #selector(settingsUpdated), name: NOTIFICATION_NAME, object: nil)
    }
    
    @objc func settingsUpdated() {
        self.viewModel.reloadInfo()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NOTIFICATION_NAME, object: nil)
        bag = nil
    }
    
}

extension CityScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K_CELL_ID) as! WeatherInfoCell
            cell.weatherView.loadInfo(model: viewModel.todayWeatherInfo())
            return cell;
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K_COLLECTION_CELL_ID) as! TableCellCollectionView
            self.configCollection(cell.collectionView)
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.totalRows == 0 {
            return nil
        }
        return section == 0 ? "Today's weather" : "Week Forecast"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return k_CELL_HEIGHT
        }
    }
    
}

extension CityScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configCollection(_ collectionView: UICollectionView) {
        let centeredCollectionViewFlowLayout = (collectionView.collectionViewLayout as! CenterCollectionViewLayout)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: K_SCREEN_SIZE.width * KWIDTH_RATIO,
            height: k_CELL_HEIGHT
        )
        centeredCollectionViewFlowLayout.minimumLineSpacing = 8
        collectionView.register(UINib(nibName: K_WEATHER_CELL, bundle: nil), forCellWithReuseIdentifier: K_WEATHER_CELL)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.totalCollectionRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K_WEATHER_CELL, for: indexPath) as! WeatherCollectionCell
        let vm = viewModel.dailyWeatherInfoFor(index: indexPath.row)
        cell.weatherView.loadInfo(model: vm)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: K_SCREEN_SIZE.width * KWIDTH_RATIO,
            height: k_CELL_HEIGHT
        )
    }
    
}

extension UIViewController {
    func showErrorAlert(err: String?) {
        guard let err =  err else {
            return
        }
        self.showAlert(msg: err)
    }
}
