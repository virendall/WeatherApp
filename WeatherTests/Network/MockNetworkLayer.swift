//
//  MockNetworkLayer.swift
//  WeatherTests
//
//  Created by Virender Dall on 31/08/21.
//

import Foundation
@testable import Weather

class MockNetworkLayer: Requestable {

    @discardableResult
    func responseData<T:Codable>(endPoint: EndPointType, params: Parameters?, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? {
        do {
            let data = try FileUtil.readJsonFile(name: endPoint.value)
            try completion(.success(data.decodeResponse()))
        } catch {
            completion(.failure(error))
        }
        return nil
    }
}
