//
//  RadarView.swift
//  UrbanGuide
//

import UIKit

class RadarView: UIView {

    let maxRadius: CGFloat = 1000
    let pointsLayer = CAShapeLayer()

    func setup() {
        let circlePath = UIBezierPath(ovalIn: bounds)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2
        self.layer.addSublayer(circleLayer)

        let centerPath = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 5, height: 5)))
        let centerLayer = CAShapeLayer()
        centerLayer.path = centerPath.cgPath
        centerLayer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(centerLayer)

        pointsLayer.lineWidth = 1
        pointsLayer.strokeColor = UIColor.white.cgColor
        pointsLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(pointsLayer)
    }

    func updatePoints(points: [(distance: Double, bearing: Double)]) {
        let pointsPath = UIBezierPath()
        let x = points.map{ pointOnCircle(radius: CGFloat($0.0), angle: CGFloat($0.1))}
        x.forEach({ pointsPath.append(UIBezierPath(ovalIn: CGRect(origin: $0, size: CGSize(width: 5, height: 5))))})
        pointsLayer.path = pointsPath.cgPath
    }

    private func pointOnCircle(radius: CGFloat, angle: CGFloat) -> CGPoint {
        let r = radius / maxRadius * (bounds.width/2)
        let x = bounds.width/2 + r * cos(angle)
        let y = bounds.height/2 + r * sin(angle)
        return CGPoint(x: x, y: y)
    }

}
