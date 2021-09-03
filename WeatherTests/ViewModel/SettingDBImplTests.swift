//
//  SettingDBImplTests.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import XCTest
@testable import Weather

class SettingDBImplTests: XCTestCase {

    var settingDB: SettingsDB!
    
    override func setUp() {
        settingDB = SettingDBImpl()
    }
    
    func test_allUnits() {
        XCTAssertEqual(2, settingDB.allUnits().count)
    }
    
    func test_getDefaultCurrentUnit() {
        XCTAssertEqual(.metric, settingDB.getCurrentUnit())
    }
    
    func test_getUpdatedCurrentUnit() {
        settingDB.saveUnit(unit: MeasureUnit.imperial.rawValue)
        XCTAssertEqual(.imperial, settingDB.getCurrentUnit())
    }
    
    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
}
