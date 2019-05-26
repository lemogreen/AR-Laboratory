//
//  LookInARVC.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 24/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Charts

class LookInARVC: UIViewController, ARSCNViewDelegate {
    
    var isExperimentPlaing: Bool = false
    var t: Double = 0
    let delta = 0.1
    var firstElem: Double = 0
    var isEditingEnabled: Bool = true
    
    
    
    
    
    //Изначальные условия
    
    //Начальное смещение
    var z_begin: Double = 0
    
    //Начальный угол поворота
    var theta_begin: Double = 0
    
    //Масса груза
    var load_mass: Double = 0.2
    
    //Масса гайки
    var nut_mass: Double = 0.01
    
    //Коэффициент жесткости
    var rigidity_cof: Double = 2
    
    //Масса стержня
    var spoke_mass: Double = 0.025
    
    //Общая масса
    var full_mass: Double = 0.34
    
    var I: Double = 1
    
    var epsilon: Double = 1
    
    var omega_z: Double = 1
    
    var omega_theta: Double = 1
    
    var w1: Double = 1
    var w2: Double = 1
    
    
    
    func calculateParametrsOfTheSystem() {
        full_mass = load_mass + 4 * nut_mass + 4 * spoke_mass
        I = (load_mass * pow(0.01, 2.0) / 2) + (spoke_mass/3) * (3 * pow(0.001, 2.0) + pow(0.03, 2.0)) + nut_mass*(pow(0.004, 2.0) + pow(0.001, 2.0)) + 4*pow(0.02, 2.0)*(nut_mass + spoke_mass)
        epsilon = rigidity_cof * 0.23 * 0.005 * sin(Double.pi*79/180)
        omega_theta = rigidity_cof / full_mass
        omega_z = rigidity_cof / full_mass
        w1 = sqrt(omega_z + sqrt(pow(epsilon, 2.0) / (load_mass * I * 4)))
        w2 = sqrt(omega_z - sqrt(pow(epsilon, 2.0) / (load_mass * I * 4)))
    }
    
    
    func changePositionOntime(t: Double) -> (Double, Double) {
        let z_position = z_begin / (pow(w1, 2.0) - pow(w2, 2.0)) * ((pow(w1, 2.0) - omega_theta)*cos(w1*t) - (pow(w2, 2) - omega_theta)*cos(w2*t)) - (2 * I * theta_begin / epsilon) / (pow(w1, 2.0) - pow(w2, 2.0)) * (pow(w1, 2.0) - omega_theta) * (pow(w2, 2.0) - omega_theta) * (cos(w1*t) - cos(w2*t))
        let theta_position = (epsilon * z_begin / 2 / I) / (pow(w1, 2.0) - pow(w2, 2.0)) * (cos(w1*t) - cos(w2*t)) + theta_begin / (pow(w1, 2.0) - pow(w2, 2.0))*((pow(w1, 2.0) - omega_theta) * cos(w2*t) - (pow(w2, 2.0) - omega_theta) * cos(w1*t))
        return (z_position, theta_position)
    }
    
    
    @IBOutlet var lineChart: LineChartView!
    
    
    @IBOutlet var graphicsView: UIVisualEffectView!
    
    @IBOutlet var configurationView: UIVisualEffectView!
    
    @IBOutlet var laboratoryARView: ARSCNView!
    
    var springTopNode: SCNNode = SCNNode()
    var springNode: SCNNode = SCNNode()
    var loadNode: SCNNode = SCNNode()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.laboratoryARView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        laboratoryARView.showsStatistics = true
        laboratoryARView.delegate = self
        
        //self.laboratoryARView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.laboratoryARView.session.run(configuration)
        self.navigationController?.isNavigationBarHidden = true
        updateGraph()
        calculateParametrsOfTheSystem()
    }
    
    
    
    @IBAction func showGraphsWasPressed(_ sender: Any) {
        graphicsView.isHidden = false
    }
    
    
    @IBAction func hideBtnWasPressed(_ sender: Any) {
        graphicsView.isHidden = true
    }
    
    
    @IBAction func configurationBtnWasPressed(_ sender: Any) {
        configurationView.isHidden = false
    }
    
    
    @IBAction func hideConfigurationWasPressed(_ sender: Any) {
        configurationView.isHidden = true
    }
    
    
    func updateGraph() {
        var lineChartEntry = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        for i in 0..<dataArrayZ.count {
            let value = ChartDataEntry(x: Double(i), y: dataArrayZ[i])
            lineChartEntry.append(value)
            let value2 = ChartDataEntry(x: Double(i), y: dataArrayTheta[i])
            lineChartEntry2.append(value2)
        }
        
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "number")
        line1.colors = [NSUIColor.blue]
        line1.drawCirclesEnabled = false
        line1.cubicIntensity = 1
        
        let line2 = LineChartDataSet(values: lineChartEntry2, label: "number2")
        line2.colors = [NSUIColor.red]
        line2.drawCirclesEnabled = false
        line2.cubicIntensity = 1
        
        
        let data = LineChartData()
        data.addDataSet(line1)
        data.addDataSet(line2)
        lineChart.data = data
        lineChart.chartDescription?.text = "dfjgfdjgkhj"
        lineChart.backgroundColor = UIColor.white
    
    }
    
    
    @IBAction func startExperimentBtnWasPressed(_ sender: Any) {
        isExperimentPlaing = !isExperimentPlaing
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if isExperimentPlaing {
            let a = changePositionOntime(t: t)
            let z = a.0
            let theta = a.1
            self.loadNode.position.y = Float(z)
            self.loadNode.eulerAngles.y = Float(theta)
            self.springNode.position.y = 0.236 + Float(z)
            updateSpringPosition()
            if (t - firstElem) >= delta
            {
                self.firstElem = t
                DispatchQueue.main.async {
                    dataArrayZ.append(Double(z))
                    dataArrayTheta.append(theta * Double.pi/180)
                    self.updateGraph()
                }
            }
            t = t + 0.016666667
        } else {return}
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dataArrayZ = []
        dataArrayTheta = []
        isExperimentPlaing = false
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func updateSpringPosition() {
        let k = (springTopNode.position.y - springNode.position.y) / 0.16
        springNode.scale.y = k
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEditingEnabled == true {
            guard let touch = touches.first else { return }
            let result = laboratoryARView.hitTest(touch.location(in: laboratoryARView), types: [ARHitTestResult.ResultType.featurePoint])
            guard let hitResult = result.last else { return }
            let hitTransform = SCNMatrix4(hitResult.worldTransform)
            let hitvector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
            let newScene = SCNScene(named: laboratoriesClasses[selectedCell].laboratoryModel)!
            let currentPendulum = newScene.rootNode.childNode(withName: "Wilberforce_Pendulum", recursively: false)!
            springTopNode = newScene.rootNode.childNode(withName: "Spring_Node_Top", recursively: true)!
            springNode = newScene.rootNode.childNode(withName: "Spring_node", recursively: true)!
            loadNode = newScene.rootNode.childNode(withName: "Load_Node", recursively: true)!
            loadNode.position.y = Float(z_begin)
            loadNode.eulerAngles.y = Float(theta_begin)
            springNode.position.y = 0.236 + Float(z_begin)
            updateSpringPosition()
            currentPendulum.position = hitvector
            laboratoryARView.scene = newScene
            self.laboratoryARView.debugOptions = []
            isEditingEnabled = false
        }
    }
    
    
    @IBAction func zBeginSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        z_begin = Double(slider.value)
        loadNode.position.y = Float(z_begin)
        springNode.position.y = 0.236 + Float(z_begin)
        updateSpringPosition()
        
    }
    
    
    @IBAction func thetaBeginSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        theta_begin = Double(slider.value)
        print(theta_begin)
        loadNode.eulerAngles.y = Float(theta_begin)
    }
    

    @IBAction func loadMassSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        load_mass = Double(slider.value)
    }
    
    @IBAction func nutMassSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        nut_mass = Double(slider.value)
    }
    
    
    @IBAction func rigidityCofSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        rigidity_cof = Double(slider.value)
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
