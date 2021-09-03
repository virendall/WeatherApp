//
//  Storyboard+Extension.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import UIKit

extension UIStoryboard {
    func loadVC<T: UIViewController>(_ type : T.Type) -> T? {
        return self.instantiateViewController(withIdentifier: T.description().className) as? T
    }
}
