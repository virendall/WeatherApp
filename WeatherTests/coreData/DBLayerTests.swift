//
//  DBLayerTests.swift
//  WeatherTests
//
//  Created by Virender Dall on 08/09/21.
//

import XCTest
@testable import Weather
import CoreData

class DBLayerTests: XCTestCase {
    
    var dbLayer: DBLayer!
    var coreDataStack: CoreDataStack!
    // swiftlint:enable implicitly_unwrapped_optional
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        dbLayer = DBLayer(stack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        dbLayer = nil
        coreDataStack = nil
    }
    
    func test_save() {
        let bookMark =  BookMarkModel(lat: 20.0, lng: 30.0, cityName: "City")
        dbLayer.save(bookMark)
        let savedBookMark = dbLayer.loadAllBookMarks().first
        XCTAssertEqual(savedBookMark?.cityName, bookMark.cityName)
    }
    
    func test_loadAllBookMarks() {
        XCTAssertEqual(0, dbLayer.loadAllBookMarks().count)
    }
    
    func test_deleteBookMark_whenNoBookMark() {
        let bookMark =  BookMarkModel(lat: 20.0, lng: 30.0, cityName: "City")
        dbLayer.delete(bookMark)
        XCTAssertEqual(0, dbLayer.loadAllBookMarks().count)
    }
    
    func test_deleteBookMark_addThenDelete() {
        let bookMark =  BookMarkModel(lat: 20.0, lng: 30.0, cityName: "City")
        dbLayer.save(bookMark)
        XCTAssertEqual(1, dbLayer.loadAllBookMarks().count)
        dbLayer.delete(bookMark)
        XCTAssertEqual(0, dbLayer.loadAllBookMarks().count)
    }
    
}
