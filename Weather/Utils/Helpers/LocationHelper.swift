//
//  LocationHelper.swift
//  Weather
//
//  Created by Virender Dall on 31/08/21.
//

import Foundation
import CoreLocation

extension CLLocation {
    func getCityName(completion: @escaping (Result<String, Error>) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self) { placeMarks, error in
            if let error = error  {
                completion(.failure(error))
                return
            }
            guard let city = placeMarks?.last?.locality else {
                completion(.failure(LocationError.unableToReverseGeoCode))
                return
            }
            completion(.success(city))
        }
    }
}
