//
//  JSONDecoder+Extension.swift
//  Weather
//
//  Created by Virender Dall on 30/08/21.
//

import Foundation

extension Data {
    func decodeResponse<T: Decodable>() throws -> T {
        LOGGER.log(data: self)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: self)
    }
}
