//
//  String+Extension.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import Foundation

extension String {
    var className:String {
        return self.components(separatedBy: ".").last!
    }
}
