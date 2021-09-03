//
//  BookMarkViewModelTests.swift
//  WeatherTests
//
//  Created by Virender Dall on 02/09/21.
//

import XCTest
@testable import Weather

class BookMarkViewModelTests: XCTestCase {
    var viewModel: BookMarkViewModel!
    var db: MockDBLayer!
    
    override func setUp() {
        db = MockDBLayer()
        viewModel = BookMarkViewModel(dataBase: db)
    }
    
    func test_whenDBHaveData() {
        XCTAssertEqual(2, viewModel.totalRows)
        XCTAssertEqual("Udaipur", viewModel.itemAt(index: 1).cityName)
        viewModel.deleteItem(index: 0)
        XCTAssertEqual(1, viewModel.totalRows)
        XCTAssertFalse(viewModel.editEnabled.value)
        viewModel.editToggle()
        XCTAssertTrue(viewModel.editEnabled.value)
    }
    
    func test_addBookMarkWhenCityExist() {
        let exp = expectation(description: "Loading city from geo location")
        viewModel.addBookMarkFor(lat: 26.9124, lng: 75.7873) { _ in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(2, viewModel.totalRows)
    }
    
    func test_addBookMarkWhenCityNotExist() {
        let exp = expectation(description: "Loading city from geo location")
        viewModel.addBookMarkFor(lat: 12.921068, lng: 77.577070) { err in
            XCTAssertNil(err)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(3, viewModel.totalRows)
    }
    
    func test_selectedLocation() {
        let exp = expectation(description: "Loading city from geo location")
        viewModel.selectedLocation(12.921068, 77.577070)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        XCTAssertEqual(3, viewModel.totalRows)
    }
    
    func test_unableToReverseGeoCode() {
        let exp = expectation(description: "Loading city from geo location")
        viewModel.addBookMarkFor(lat: 0, lng: 0) { err in
            exp.fulfill()
            XCTAssertNotNil(err)
        }
        waitForExpectations(timeout: 3)
    }
    
    func test_filterCities_whenCityIsNilorBlank() {
        viewModel.filterCities(cityName: nil)
        XCTAssertEqual(2, viewModel.totalRows)
        viewModel.filterCities(cityName: "")
        XCTAssertEqual(2, viewModel.totalRows)
    }
    func test_filterCities_whenCityNameIsNotBlank() {
        viewModel.filterCities(cityName: "Jaipur")
        XCTAssertEqual(1, viewModel.totalRows)
        viewModel.filterCities(cityName: "Bikaner")
        XCTAssertEqual(0, viewModel.totalRows)
    }
}


class MockDBLayer: Database {
    var bookMarks = [
        BookMarkModel(lat: 26.9124, lng:75.7873, cityName: "Jaipur"),
        BookMarkModel(lat: 26.9124, lng:75.7873, cityName: "Udaipur")]

    
    func delete(_ bookMark: BookMarkModel) {
        if let index = bookMarks.firstIndex(where: { $0.cityName == bookMark.cityName }) {
            bookMarks.remove(at: index)
        }
    }
    
    func loadAllBookMarks() -> [BookMarkModel] {
        return bookMarks
    }
    
    func save(_ bookMark: BookMarkModel) {
        bookMarks.append(bookMark)
    }
    
}
