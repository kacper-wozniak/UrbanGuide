//
//  AugmentedViewController.swift
//  UrbanGuide
//

import UIKit
import CoreLocation
import CoreMotion

class AugmentedViewController: UIViewController {

    @IBOutlet weak var cameraPreviewView: UIView!
    @IBOutlet weak var augmentedView: AugmentedView!
    @IBOutlet weak var radarView: RadarView!
    @IBOutlet weak var pointsCountLabel: UILabel!

    private let locationManager = CLLocationManager()

    func setupLocationManager() {
        locationManager.desiredAccuracy = 1
        locationManager.distanceFilter = 10
        locationManager.headingFilter = 1
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    let motionManager = CMMotionManager()

    func setupMotionManager() {
        motionManager.deviceMotionUpdateInterval = 1/60
        motionManager.showsDeviceMovementDisplay = true
    }

    let cameraManager = CameraManager()

    func setupCameraManager() {
        guard let previewLayer = cameraManager.previewLayer else { return }
        previewLayer.frame = cameraPreviewView.frame
        cameraPreviewView.layer.addSublayer(previewLayer)
    }

    let pointsOfInterest = PointsOfInterest()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard motionManager.isDeviceMotionAvailable else { return }
        setupCameraManager()
        setupLocationManager()
        setupMotionManager()
        cameraManager.startCapture()
        radarView.setup()
        augmentedView.setupScene(fieldOfView: cameraManager.fieldOfView)
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue()) {
            [weak self] (motion, error) in
            guard let heading = self?.locationManager.heading?.magneticHeading.degreesToRadians else { return }
            DispatchQueue.main.async {
                self?.radarView.transform = CGAffineTransform(rotationAngle: CGFloat(-heading - .pi/2))
            }
            guard let orientation = motion?.orientation else { return }
            self?.augmentedView.update(cameraOrientation: orientation)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let id = sender as? Int,
            let pointOfInterest = pointsOfInterest.point(withId: id),
            let details = segue.destination as? PointOfInterestDetailsViewController
        {
            details.pointOfInterest = pointOfInterest
        }
    }
    
    func update(location: CLLocation) {
        let pointsInRange = pointsOfInterest.near(location)
        let radarPoints = pointsInRange.map { ($0.distance, $0.bearing) }
        pointsCountLabel.text = "There \(pointsInRange.count == 1 ? "is" : "are") \(pointsInRange.count) points of interest in your area."
        radarView.updatePoints(points: radarPoints)
        augmentedView.update(points: pointsInRange)
    }

    @IBAction func onSceneTap(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: augmentedView)
        if let id = augmentedView.hitTest(point, options: nil).first?.node.name {
            performSegue(withIdentifier: "details", sender: Int(id))
        }
    }

    deinit {
        motionManager.stopDeviceMotionUpdates()
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
        cameraManager.stopCapture()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
}
