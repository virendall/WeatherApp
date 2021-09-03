//
//  EndPointType.swift
//  Receipe_App
//
//  Created by Virender Dall on 06/11/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation

public typealias Headers = [String : String]

public protocol EndPointType {
    var headers: Headers { get }
    var value: String { get }
    func url(params: Parameters?) -> URL
}
