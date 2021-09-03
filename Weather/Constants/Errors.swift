//
//  Errors.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import Foundation

enum NetworkError: Error {
    case InvalidResponse
    case BadRequest
}

enum LocationError: Error {
    case unableToReverseGeoCode
}
