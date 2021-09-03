//
//  Storyboarded.swift
//  Receipe_App
//
//  Created by Virender Dall on 06/11/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ title: String? = nil, msg: String?, buttonText: String = "OK") {
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showActionSheet(msg: String?, buttons:[String], cancelTitle: String = "Cancel", clickedItem:@escaping ((String) -> Void), view: UIView) {
        let alert = UIAlertController(
            title: nil,
            message: msg,
            preferredStyle: .actionSheet
        )
        
        if  UIDevice.current.userInterfaceIdiom == .pad {
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = view.bounds            
        }
        
        for item in buttons {
            alert.addAction(UIAlertAction(title: item, style: .default, handler: { (action) in
                clickedItem(item)
            }))
        }
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
