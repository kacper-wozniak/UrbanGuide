//
//  AugmentedViewController+CLLocationManagerDelegate.swift
//  UrbanGuide
//

import CoreLocation
import UIKit

extension AugmentedViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        update(location: location)
    }

}
