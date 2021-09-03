//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Virender Dall on 30/08/21.
//

import XCTest
@testable import Weather

class WeatherViewModelTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var settingDB = MockSettingDB()
    var networkLayer = MockNetworkLayer()
    
    override func setUp() {
        viewModel = WeatherViewModel(networkLayer: networkLayer, settingDB: settingDB)
    }
    
    func testWeather_whenAPIReturnSuccessResponse() {
        viewModel.getWeatherFor(lat: 26.9124, lng: 75.7873, endPoint: MockWeatherEndPoint.weather)
        XCTAssertNotNil(viewModel.cityWeather.value)
        XCTAssertEqual(1, viewModel.totalRows)
        XCTAssertEqual(7, viewModel.totalCollectionRows)
        XCTAssertNotNil(viewModel.dailyWeatherInfoFor(index:0))
        XCTAssertNotNil(viewModel.todayWeatherInfo)
        XCTAssertEqual("13°C", viewModel.todayWeatherInfo()!.temp)
        settingDB.saveUnit(unit: MeasureUnit.metric.rawValue)
        viewModel.reloadInfo()
        XCTAssertEqual("55°F", viewModel.todayWeatherInfo()!.temp)
    }
    
    func testWeather_whenAPIReturnErrorResponse() {
        viewModel.getWeatherFor(lat: 26.9124, lng: 75.7873, endPoint: MockWeatherEndPoint.weatherFailuer)
        viewModel.reloadInfo()
        XCTAssertNil(viewModel.cityWeather.value)
        XCTAssertNil(viewModel.todayWeatherInfo())
        XCTAssertNil(viewModel.dailyWeatherInfoFor(index:0))
        XCTAssertEqual(0, viewModel.totalRows)
        XCTAssertEqual(0, viewModel.totalCollectionRows)
    }
    
    func test_CityWeatherViewModel_whenInputNil() {
        XCTAssertNil(CityWeatherViewModel.init(nil))
    }
    
    func test_CityWeatherViewModel_whenInputHaveValue() {
        viewModel.getWeatherFor(lat: 26.9124, lng: 75.7873, endPoint: MockWeatherEndPoint.weather)
        var val = viewModel.cityWeather.value?.daily.first
        val?.weather = []
        let vm = CityWeatherViewModel.init(val)
        XCTAssertNil(vm?.weatherIcon)
        XCTAssertNil(vm?.weather)
        XCTAssertNotNil(vm)
    }
    
    func test_temperature_whenUnitIsMetric() {
        XCTAssertEqual("55°F", MeasureUnit.metric.temperature(tempInC: 13))
        XCTAssertEqual("7km/hr", MeasureUnit.metric.speed(inMeterSec: 2))
    }
    func test_temperature_whenUnitIsImperial() {
        XCTAssertEqual("13°C", MeasureUnit.imperial.temperature(tempInC: 13))
        XCTAssertEqual("4mph", MeasureUnit.imperial.speed(inMeterSec: 2))
    }
}

class MockSettingDB: SettingsDB {
    
    private var updatedUnit: MeasureUnit = .imperial
    
    func allUnits() -> [String] {
        return MeasureUnit.allCases.compactMap { $0.rawValue }
    }
    
    func saveUnit(unit: String) {
        updatedUnit = .metric
    }
    
    func getCurrentUnit() -> MeasureUnit {
        return updatedUnit
    }
    
}
