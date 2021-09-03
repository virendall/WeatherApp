//
//  SettingViewModel.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import UIKit

protocol SettingsDB {
    func allUnits() -> [String]
    func saveUnit(unit: String)
    func getCurrentUnit() -> MeasureUnit
}

class SettingDBImpl: SettingsDB {
    private let UNIT_KEY = "Unit"
    private let userDefaults = UserDefaults.standard
    func allUnits() -> [String] {
        return MeasureUnit.allCases.map { $0.rawValue }
    }
    
    func saveUnit(unit: String) {
        userDefaults.set(unit, forKey: UNIT_KEY)
        userDefaults.synchronize()
    }
    
    func getCurrentUnit() -> MeasureUnit {
        let defaultValue = MeasureUnit.metric
        if let string = userDefaults.string(forKey: UNIT_KEY) {
            return MeasureUnit.init(rawValue: string) ?? defaultValue
        }
        return defaultValue
    }
}

class SettingViewModel {
    
    let settingDB: SettingsDB
    
    init(settingDB: SettingsDB = SettingDBImpl()) {
        self.settingDB = settingDB
    }
    
    func allUnits() -> [String] {
        return settingDB.allUnits()
    }
    
    func currentUnit() -> MeasureUnit {
        return settingDB.getCurrentUnit()
    }
    
    func saveUnit(unit: String) {
        settingDB.saveUnit(unit: unit)
    }
    
}
