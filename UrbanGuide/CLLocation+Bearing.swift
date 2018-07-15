//
//  CLLocation+Bearing.swift
//  UrbanGuide
//

import CoreLocation

extension CLLocation {

    func bearing(to destination: CLLocation) -> CLLocationDegrees {
        let lat1 = coordinate.latitude
        let lon1 = coordinate.longitude
        let lat2 = destination.coordinate.latitude
        let lon2 = destination.coordinate.longitude
        let φ1 = lat1.degreesToRadians
        let φ2 = lat2.degreesToRadians
        let Δλ = (lon2 - lon1).degreesToRadians
        let y = sin(Δλ) * cos(φ2)
        let x = cos(φ1) * sin(φ2) - sin(φ1) * cos(φ2) * cos(Δλ)
        return atan2(y, x)
    }

}
