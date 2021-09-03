//
//  MockWeatherEndPoint.swift
//  WeatherTests
//
//  Created by Virender Dall on 31/08/21.
//

import Foundation
@testable import Weather

enum MockWeatherEndPoint: String {
    case weather
    case weatherFailuer
}

extension MockWeatherEndPoint: EndPointType {
    
    var value: String {
        return self.rawValue
    }
    
    func url(params: Parameters?) -> URL {
        let urlComponents = NSURLComponents(string: self.url)!
        urlComponents.queryItems = params?.keys.map {  URLQueryItem(name: $0, value: String(describing: params![$0, default: ""])) }
        return urlComponents.url!
    }
    
    var url: String {
        let url = API_BASE_URL + "/data/2.5/"
        return url + "weather"
    }
    
    var headers: Headers {
        return [:]
    }
    
}
