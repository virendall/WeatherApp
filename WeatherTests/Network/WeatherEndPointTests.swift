//
//  WeatherEndPointTests.swift
//  WeatherTests
//
//  Created by Virender Dall on 31/08/21.
//

import XCTest

@testable import Weather

class WeatherEndPointTests: XCTestCase {
    
    var endPoint: EndPointType = WeatherEndPoint.weather
    
    func test_url_whenParamsNotNil() throws {
        XCTAssertEqual([:], endPoint.headers)
        XCTAssertEqual("https://api.openweathermap.org/data/2.5/onecall?q=London", endPoint.url(params: ["q" : "London"]).absoluteString)
    }
    
    func test_url_whenParamsNil() throws {
        XCTAssertEqual([:], endPoint.headers)
        XCTAssertEqual("https://api.openweathermap.org/data/2.5/onecall", endPoint.url(params: nil).absoluteString)
    }
}
