//
//  ViewController.swift
//  World Tracking
//
//  Created by Dongcheng Deng on 2018-03-21.
//  Copyright © 2018 Showpass. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

  @IBOutlet weak var sceneView: ARSCNView!
  
  let configuration = ARWorldTrackingConfiguration()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    self.sceneView.session.run(configuration)
    sceneView.autoenablesDefaultLighting = true
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func add(_ sender: Any) {
    let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
    doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
    let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
    boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    let node = SCNNode()

    node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
    node.geometry?.firstMaterial?.specular.contents = UIColor.white
    node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    node.position = SCNVector3(0.2, 0.3, -0.2)
    node.eulerAngles = SCNVector3(Float(180.degreesToRadians), 0, 0)
    boxNode.position = SCNVector3(0, -0.05, 0)
    doorNode.position = SCNVector3(0, -0.02, 0.051)

    self.sceneView.scene.rootNode.addChildNode(node)
    node.addChildNode(boxNode)
    boxNode.addChildNode(doorNode)

    
  }
  
  @IBAction func reset(_ sender: Any) {
    restartSession()
  }
  
  func restartSession() {
    self.sceneView.session.pause()
    self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
      node.removeFromParentNode()
    }
    
    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }
  
  func randomNumbers(first: CGFloat, second: CGFloat) -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(first - second) + min(first, second)
  }
}

extension Int {
  var degreesToRadians: Double { return Double(self) * .pi/180 }
}
