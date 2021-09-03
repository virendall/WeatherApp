//
//  DBLayer.swift
//  Weather
//
//  Created by Virender Dall on 01/09/21.
//

import Foundation
import CoreData

class DBLayer: Database {
    
    private func coreDataRecords() -> [BookMarks] {
        return CoreDataHelper.shared.allRecords(BookMarks.self, sort: NSSortDescriptor(key: "date", ascending: false))
    }
    
    func delete(_ bookMark: BookMarkModel) {
        if let object = coreDataRecords().filter({ $0.cityName == bookMark.cityName }).first {
            CoreDataHelper.shared.deleteRecord(object)
            CoreDataHelper.shared.saveDatabase()
        }
    }
    
    func loadAllBookMarks() -> [BookMarkModel] {
        let records = coreDataRecords()
        return records.map { bookMarks in
            BookMarkModel(lat: bookMarks.lat, lng: bookMarks.lng, cityName: bookMarks.cityName!)
        }
    }
    
    func save(_ bookMark: BookMarkModel) {
        let dbBookMark = CoreDataHelper.shared.addRecord(BookMarks.self)
        dbBookMark.lat = bookMark.lat
        dbBookMark.lng = bookMark.lng
        dbBookMark.cityName = bookMark.cityName
        dbBookMark.date = Date()
        CoreDataHelper.shared.saveDatabase()
    }
    
}
