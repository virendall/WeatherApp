//
//  Database.swift
//  Weather
//
//  Created by Virender Dall on 01/09/21.
//

import Foundation
import CoreData

protocol Database {
    func loadAllBookMarks() -> [BookMarkModel]
    func save(_ bookMark: BookMarkModel)
    func delete(_ bookMark: BookMarkModel)
}
