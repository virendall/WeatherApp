//
//  Requestable.swift
//  Receipe_App
//
//  Created by Virender Dall on 06/11/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation

public typealias Parameters = [String : Any]

protocol Requestable {
    
    @discardableResult
    func responseData<T:Codable>(endPoint: EndPointType, params: Parameters?, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask?
}
