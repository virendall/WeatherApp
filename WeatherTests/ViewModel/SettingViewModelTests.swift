//
//  SettingViewModel.swift
//  WeatherTests
//
//  Created by Virender Dall on 02/09/21.
//



import XCTest
@testable import Weather

class SettingViewModelTests: XCTestCase {

    var settingViewModel: SettingViewModel!
    
    var db: SettingsDB!
    
    override func setUp() {
        db = MockSettingDB()
        settingViewModel = SettingViewModel(settingDB: db)
    }
    
    func test_allUnits() {
        XCTAssertEqual(2, settingViewModel.allUnits().count)
    }
    
    func test_currentUnit() {
        XCTAssertEqual(.imperial, settingViewModel.currentUnit())
    }
    
    func test_saveUnit() {
        settingViewModel.saveUnit(unit: MeasureUnit.metric.rawValue)
        XCTAssertEqual(.metric, settingViewModel.currentUnit())
    }
}


