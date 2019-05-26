//
//  LookIn3DVC.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 24/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import UIKit
import SceneKit

class LookIn3DVC: UIViewController, SCNSceneRendererDelegate {
    
    
    @IBOutlet var sceneView: SCNView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.allowsCameraControl = true
        sceneView.scene = SCNScene(named: laboratoriesClasses[selectedCell].laboratoryModel)
        sceneView.delegate = self
        //self.navigationItem.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

