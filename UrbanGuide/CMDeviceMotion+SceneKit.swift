//
//  CMDeviceMotion+SceneKit.swift
//  UrbanGuide
//

import CoreMotion
import SceneKit

extension CMDeviceMotion {

    var orientation: SCNQuaternion {
        let q1 = GLKQuaternion(q: attitude.quaternion)
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            let q2 = GLKQuaternionMakeWithAngleAndAxis(-.pi/2, 1, 0, 0)
            let q = GLKQuaternionMultiply(q2, q1)
            return SCNQuaternion(q.x, q.y, q.z, q.w)
        case .portraitUpsideDown:
            let q2 = GLKQuaternionMakeWithAngleAndAxis(.pi/2, 1, 0, 0)
            let q = GLKQuaternionMultiply(q2, q1)
            return SCNQuaternion(-q.x, -q.y, q.z, q.w)
        case .landscapeLeft:
            let q2 = GLKQuaternionMakeWithAngleAndAxis(-.pi/2, 0, 1, 0)
            let q = GLKQuaternionMultiply(q2, q1)
            return SCNQuaternion(q.y, -q.x, q.z, q.w)
        case .landscapeRight:
            let q2 = GLKQuaternionMakeWithAngleAndAxis(.pi/2, 0, 1, 0)
            let q = GLKQuaternionMultiply(q2, q1)
            return SCNQuaternion(-q.y, q.x, q.z, q.w)
        case .unknown:
            return SCNVector4Zero
        }
    }

}

extension GLKQuaternion {

    init(q: CMQuaternion) {
        self.q = (Float(q.x), Float(q.y), Float(q.z), Float(q.w))
    }
    
}
