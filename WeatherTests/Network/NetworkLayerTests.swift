//
//  NetworkLayerTests.swift
//  WeatherTests
//
//  Created by Virender Dall on 03/09/21.
//

import XCTest

@testable import Weather

struct TestDecodable: Codable, Equatable {
    let age: Int
}

class NetworkLayerTests: XCTestCase {
    
    let data = """
      {
          "age" : 42
      }
      """.data(using: .utf8)!
    
    var mockedRequestExecutor: MockedRequestExecutor!
    override func setUp() {
        mockedRequestExecutor = MockedRequestExecutor()
    }
    
    func testGet_whenSucceed() throws {
        let params = ["q": "London"]
        mockedRequestExecutor.executeClosure = { url, callback in
            XCTAssertEqual(url, MockWeatherEndPoint.weather.url(params: params))
            callback(self.data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }
        let liveNetworkClient = NetworkLayer(requestExecutor: mockedRequestExecutor)
        liveNetworkClient.responseData(endPoint: MockWeatherEndPoint.weather, params: params) { (result: Result<TestDecodable, Error>) in
            switch result {
            case .success(let result):
                XCTAssertEqual(result, TestDecodable(age: 42))
            case .failure:
                XCTFail("Should return success response")
            }
        }
        XCTAssertEqual(mockedRequestExecutor.executeCount, 1)
    }
    
    func testGet_whenDataNil() throws {
        mockedRequestExecutor.executeClosure = { url, callback in
            callback(nil, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }
        let liveNetworkClient = NetworkLayer(requestExecutor: mockedRequestExecutor)
        liveNetworkClient.responseData(endPoint: MockWeatherEndPoint.weather, params: nil) { (result: Result<TestDecodable, Error>) in
            switch result {
            case .success(_):
                XCTFail("Should return empty error")
            case .failure(let error):
                XCTAssertEqual(NetworkError.InvalidResponse, error as! NetworkError)
            }
        }
        XCTAssertEqual(mockedRequestExecutor.executeCount, 1)
    }
    
    func testGet_whenSessionReturnError() throws {
        mockedRequestExecutor.executeClosure = { url, callback in
            callback(nil, HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil), NetworkError.BadRequest)
        }
        let liveNetworkClient = NetworkLayer(requestExecutor: mockedRequestExecutor)
        liveNetworkClient.responseData(endPoint: MockWeatherEndPoint.weather, params: nil) { (result: Result<TestDecodable, Error>) in
            switch result {
            case .success(_):
                XCTFail("Should return bad request error")
            case .failure(let error):
                XCTAssertEqual(NetworkError.BadRequest, error as! NetworkError)
            }
        }
        XCTAssertEqual(mockedRequestExecutor.executeCount, 1)
    }
    
    func testGet_whenUnableToDecodeData() throws {
        let data = """
          {
              "age" : "42"
          }
          """.data(using: .utf8)!
        mockedRequestExecutor.executeClosure = { url, callback in
            callback(data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }
        let liveNetworkClient = NetworkLayer(requestExecutor: mockedRequestExecutor)
        liveNetworkClient.responseData(endPoint: MockWeatherEndPoint.weather, params: nil) { (result: Result<TestDecodable, Error>) in
            switch result {
            case .success(_):
                XCTFail("Should return bad request error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        XCTAssertEqual(mockedRequestExecutor.executeCount, 1)
    }
}

class MockedRequestExecutor: URLRequestExecutor {
    func execute(with url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        executeCount += 1
        self.executeClosure(url, callback)
        return nil
    }
    
    var executeCount = 0
    var executeClosure: ( _ url: URL, _ callback: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void = { _, _ in
        XCTFail("execute closure not set")
    }
}
