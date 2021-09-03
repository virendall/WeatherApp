//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Virender Dall on 30/08/21.
//

import XCTest
@testable import Weather
import CoreLocation

class WeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let exp = expectation(description: "Loading stories")

        func getReverSerGeoLocation(location : CLLocation) {
            print("getting Address from Location cordinate")

            CLGeocoder().reverseGeocodeLocation(location) {
                placemarks , error in
            
                if error == nil && placemarks!.count > 0 {
                    guard let placemark = placemarks?.last else {
                        return
                    }
                    print(placemark.thoroughfare)
                    print(placemark.subThoroughfare)
                    print("postalCode :-",placemark.postalCode)
                    print("City :-",placemark.locality)
                    print("subLocality :-",placemark.subLocality)
                    print("subAdministrativeArea :-",placemark.subAdministrativeArea)
                    print("Country :-",placemark.country)
                }
                exp.fulfill()

            }
        }
        getReverSerGeoLocation(location: CLLocation(latitude: 26.9124, longitude: 75.7873))
        waitForExpectations(timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
