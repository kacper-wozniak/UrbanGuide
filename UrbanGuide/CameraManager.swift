//
//  CameraManager.swift
//  UrbanGuide
//

import AVFoundation
import UIKit

class CameraManager {

    private let camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    private let sessionQueue = DispatchQueue(label: "cameraCaptureSessionQueue", attributes: [])
    private let session = AVCaptureSession()

    init() {
        session.sessionPreset = AVCaptureSessionPresetPhoto
        guard let input = try? AVCaptureDeviceInput(device: camera) else { return }
        session.addInput(input)
    }

    var previewLayer: AVCaptureVideoPreviewLayer? {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        return previewLayer
    }

    var fieldOfView: (x: Double, y: Double) {
        let yFov = camera!.activeFormat.videoFieldOfView
        let xFov = CGFloat(yFov) / UIScreen.main.bounds.height * UIScreen.main.bounds.width
        return (Double(xFov), Double(yFov))
    }

    func startCapture() {
        sessionQueue.async { [weak self] in
            self?.session.startRunning()
        }
    }

    func stopCapture() {
        sessionQueue.async { [weak self] in
            self?.session.stopRunning()
        }
    }
    
}
