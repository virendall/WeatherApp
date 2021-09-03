//
//  SearchEndPoint.swift
//  Receipe_App
//
//  Created by Virender Dall on 06/11/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

enum WeatherEndPoint: String {
    case weather
}

extension WeatherEndPoint: EndPointType {
    
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
        switch self {
        case .weather:
            return url + "onecall"
        }
    }
    
    var headers: Headers {
        return [:]
    }
    
}
