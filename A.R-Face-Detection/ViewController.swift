//
//  ViewController.swift
//  A.R-Face-Detection
//
//  Created by Rustem Manafov on 01.01.23.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: ARSCNView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceView.delegate = self
        
        guard ARFaceTrackingConfiguration.isSupported else {
            statusLabel.text = "AR Face Detection is not supported in this device"
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = AROrientationTrackingConfiguration()  //ARFaceTrackingConfiguration
        faceView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        faceView.session.pause()
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = faceView.device else { return nil }
        
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let faceNote = SCNNode(geometry: faceGeometry)
        faceNote.geometry?.firstMaterial?.fillMode = .lines
        return faceNote
    }
}

