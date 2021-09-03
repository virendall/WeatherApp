//
//  BookMarkViewModel.swift
//  Weather
//
//  Created by Virender Dall on 31/08/21.
//

import Foundation
import CoreLocation

class BookMarkViewModel {
    
    public private(set) var bookMarks: Box<[BookMarkModel]> = Box([])
    
    public private(set) var editEnabled: Box<Bool> = Box(false)
    
    public private(set) var bookMarkError: Box<String?> = Box(nil)
    
    private let dataBase: Database
    
    private var loadedBookMarks: [BookMarkModel] = []
    
    var totalRows: Int {
        return bookMarks.value.count
    }
    
    init(dataBase: Database = DBLayer()) {
        self.dataBase = dataBase
       fetchBookMarks()
    }
    
    private func fetchBookMarks() {
        loadedBookMarks = dataBase.loadAllBookMarks()
        bookMarks.value = loadedBookMarks
    }
    
    private func saveBookMark(_ lat: Double, _ lng: Double, _ cityName: String) {
        let count = bookMarks.value.filter { $0.cityName == cityName }.count
        if count == 0 {
            let bookMark = BookMarkModel(lat: lat, lng: lng, cityName: cityName)
            dataBase.save(bookMark)
            fetchBookMarks()
        }
    }
    
    func itemAt(index: Int) -> BookMarkModel {
        return self.bookMarks.value[index]
    }
    
    func deleteItem(index: Int) {
        let bookMark = itemAt(index: index)
        dataBase.delete(bookMark)
        self.bookMarks.value.remove(at: index)
    }
    
    func editToggle() {
        self.editEnabled.value.toggle()
    }
    
    func filterCities(cityName: String?) {
        if cityName?.isEmpty ?? true {
            bookMarks.value = loadedBookMarks
        } else {
            bookMarks.value = loadedBookMarks.filter { $0.cityName.lowercased().contains(cityName!.lowercased()) }
        }
    }
}

extension BookMarkViewModel: MapDelegate {
    func selectedLocation(_ lat: Double, _ lng: Double) {
        self.addBookMarkFor(lat: lat, lng: lng)
    }
}

extension BookMarkViewModel {
    func addBookMarkFor(lat: Double, lng: Double, completion: ((Error?) -> Void)? = nil) {
        CLLocation(latitude: lat, longitude: lng).getCityName {[weak self] result in
            switch result {
            case .success(let cityName):
                self?.saveBookMark(lat, lng, cityName)
                completion?(nil)
            case .failure(let error):
                self?.bookMarkError.value = error.localizedDescription
                completion?(error)
            }
        }
    }
}
