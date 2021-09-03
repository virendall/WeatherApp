//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Virender Dall on 30/08/21.
//

import UIKit
import CoreLocation

class WeatherViewModel {
    
    private let networkLayer: Requestable
    private let settingDB: SettingsDB
    
    public private(set) var cityWeather: Box<CityWeatherModel?> = Box(nil)
    public private(set) var weatherAPIError: Box<String?> = Box(nil)
    
    private var dailyWeather: [CityWeatherViewModel]?
    private var todayWeather: CityWeatherViewModel?
    
    init(networkLayer: Requestable = NetworkLayer(), settingDB: SettingsDB = SettingDBImpl()) {
        self.networkLayer = networkLayer
        self.settingDB = settingDB
    }
    
    var totalRows: Int {
        cityWeather.value != nil ? 1 : 0
    }
    
    var totalCollectionRows: Int {
        dailyWeather?.count ?? 0
    }
    
    func todayWeatherInfo() -> CityWeatherViewModel? {
        todayWeather
    }
    
    
    func dailyWeatherInfoFor(index: Int) -> CityWeatherViewModel? {
        dailyWeather?[index]
    }
    
    private func loadWeatherViewModel(_ model: CityWeatherModel) {
        dailyWeather = model.daily.compactMap{ CityWeatherViewModel($0, unit: self.settingDB.getCurrentUnit()) }
        todayWeather = dailyWeather?.removeFirst()
    }
    
    func reloadInfo() {
        guard let val = self.cityWeather.value else {
            return
        }
        loadWeatherViewModel(val)
        cityWeather.notifyListeners()
    }
}

extension WeatherViewModel {
    func getWeatherFor(lat: Double, lng: Double, endPoint: EndPointType = WeatherEndPoint.weather) {
        let queryParams:  Parameters = ["lat": lat,
                                        "lon" : lng,
                                        "appid" : API_KEY,
                                        "exclude": "minutely,hourly,alerts",
                                        "units": "metric"]
        networkLayer.responseData(endPoint: endPoint, params: queryParams) { [weak self](response: Result<CityWeatherModel, Error>) in
            switch response {
            case .success(let model):
                self?.loadWeatherViewModel(model)
                self?.cityWeather.value = model
            case .failure(let error):
                self?.weatherAPIError.value = error.localizedDescription
                LOGGER.log(msg: error)
            }
        }
    }
}

struct CityWeatherViewModel {
    let dateString: String
    let temp: String
    let humidity: String
    let clouds: String
    let windSpeed: String
    let weather: String?
    let weatherIcon: String?
    
    init?(_ weatherModel: Daily?, unit: MeasureUnit = .metric) {
        guard let  weatherModel = weatherModel else {
            return nil
        }
        let date = Date(timeIntervalSince1970: TimeInterval(weatherModel.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        self.dateString = dateFormatter.string(from: date)
        self.temp = unit.temperature(tempInC:weatherModel.temp.day)
        self.humidity = "\(weatherModel.humidity)%"
        self.clouds = "\(Int(weatherModel.clouds))%"
        self.windSpeed = unit.speed(inMeterSec: weatherModel.windSpeed)
        self.weather = weatherModel.weather.first?.weatherDescription
        if let icon = weatherModel.weather.first?.icon {
            self.weatherIcon = "\(IMAGE_BASE_URL)\(icon).png"
        } else {
            self.weatherIcon = nil
        }
    }
}


extension MeasureUnit {
    func temperature(tempInC: Double) -> String {
        if self == .metric {
            return "\(Int((tempInC * 9/5) + 32))°F"
        }
        return "\(Int(tempInC.rounded()))°C"
    }
    
    func speed(inMeterSec: Double) -> String {
        if self == .metric {
            return "\(Int(inMeterSec * 3.6))km/hr"
        }
        return "\(Int(inMeterSec * 2.237))mph"
    }
}
