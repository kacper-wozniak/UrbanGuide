//
//  AugmentedView.swift
//  UrbanGuide
//

import SceneKit

class AugmentedView: SCNView {

    private let cameraNode = SCNNode()
    private var nodes = [SCNNode]()
    
    func setupScene(fieldOfView: (x: Double, y: Double)) {
        scene = SCNScene()
        let camera = SCNCamera()
        camera.xFov = fieldOfView.x
        camera.yFov = fieldOfView.y
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 0)
        scene?.rootNode.addChildNode(cameraNode)
    }

    func update(points: [(data: PointOfInterest, distance: Double, bearing: Double)]) {
        clearScene()
        for point in points {
            let poiView = PointOfInterestView.view
            poiView.configure(point.data, point.distance)
            let image = poiView.toImage()
            let plane = SCNPlane(width: 10, height: 10)
            plane.firstMaterial?.diffuse.contents = image
            let node = SCNNode(geometry: plane)
            node.position = positionFor(point.distance, point.bearing)
            node.name = String(point.data.id)
            let constraint = SCNBillboardConstraint()
            constraint.freeAxes = .Y
            node.constraints = [constraint]
            scene?.rootNode.addChildNode(node)
            nodes.append(node)
        }
    }

    func update(cameraOrientation orientation: SCNQuaternion) {
        cameraNode.orientation = orientation
    }

    private func positionFor(_ distance: Double, _ angle: Double) -> SCNVector3 {
        let r = (35 + distance/40)
        let x = r * cos(angle)
        let z = r * sin(angle)
        let y = distance/50 - 10
        return SCNVector3(x, y, z)
    }

    private func clearScene() {
        for node in nodes {
            node.removeFromParentNode()
        }
        nodes.removeAll()
    }

}
