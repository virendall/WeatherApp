//
//  MapSceneViewController.swift
//  Weather
//
//  Created by Virender Dall on 01/09/21.
//

import UIKit
import MapKit

protocol MapDelegate {
    func selectedLocation(_ lat: Double, _ lng: Double)
}

class MapSceneViewController: UIViewController {

    @IBOutlet var map: MKMapView!
    
    @IBOutlet var pinBottomConstraint: NSLayoutConstraint!
    
    var delegate: MapDelegate?
    
//    private var bottomConstaintValue: CGFloat = 0
    
//    private let animateValue: CGFloat = -2
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bottomConstaintValue = pinBottomConstraint.constant
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(map.centerCoordinate)
    }

    @IBAction func done() {
        let coordinate = map.centerCoordinate
        delegate?.selectedLocation(coordinate.latitude, coordinate.longitude)
        self.cancel()
    }
    
    @IBAction func cancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension MapSceneViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        UIView.animate(withDuration: 1) {[unowned self] in
//            self.pinBottomConstraint.constant = self.animateValue + self.bottomConstaintValue
//        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        UIView.animate(withDuration: 1) {[unowned self] in
//            self.pinBottomConstraint.constant = self.bottomConstaintValue
//        }
    }
}
