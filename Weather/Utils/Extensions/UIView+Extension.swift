//
//  UIView+Extension.swift
//  Weather
//
//  Created by Virender Dall on 31/08/21.
//

import UIKit

extension UIView {
    func setTLBRForView(view:UIView, padding:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)){
        let superview = self
        view.translatesAutoresizingMaskIntoConstraints = false;
        superview.addConstraints([
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: padding.top),
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1.0, constant: padding.left),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: padding.bottom),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1.0, constant: padding.right)
        ]);
    }
    
    @discardableResult
    func loadView<T:UIView>(_ type : T.Type) -> T? {
        return Bundle.main.loadNibNamed(T.description().className, owner: self, options: nil)?[0] as? T
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map(UIColor.init) }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue ; layer.masksToBounds = true;}
    }
}
