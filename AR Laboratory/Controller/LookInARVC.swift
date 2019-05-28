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
    
    @IBOutlet var configurationBtn: RoundedButtonView!
    @IBOutlet var graphicsBtn: RoundedButtonView!
    
    //Sliders
    @IBOutlet var zBeginSlider: UISlider!
    @IBOutlet var z_beginLabel: UILabel!
    
    
    @IBOutlet var thetaBeginSlider: UISlider!
    @IBOutlet var thetaBeginlabel: UILabel!
    
    
    @IBOutlet var loadMassslider: UISlider!
    @IBOutlet var loadMassLabel: UILabel!
    
    
    @IBOutlet var nutMassSlider: UISlider!
    @IBOutlet var nutMassLabel: UILabel!
    
    
    @IBOutlet var rigidityCofSlider: UISlider!
    
    @IBOutlet var rigidityCofLabel: UILabel!
    
    
    func enableAllsliders() {
        zBeginSlider.isEnabled = true
        thetaBeginSlider.isEnabled = true
        loadMassslider.isEnabled = true
        nutMassSlider.isEnabled = true
        rigidityCofSlider.isEnabled = true
    }
    
    func disableAllSliders() {
        zBeginSlider.isEnabled = false
        thetaBeginSlider.isEnabled = false
        loadMassslider.isEnabled = false
        nutMassSlider.isEnabled = false
        rigidityCofSlider.isEnabled = false
    }
    
    //TODO: возможно это как то можно убрать
    let wilberForcePendulum = WilberforcePendulumBehavior()
    
    
    //TODO: - Добавить условия блокировки слайдеров
    //TODO: - Добавить аннотации когда меняют конфигурацию системы
    //TODO: - Сделать кнопки запуска и остановки эксперимента
    
    
    var isExperimentPlaing: Bool = false
    var t: Double = 0
    let delta = 0.1
    var firstElem: Double = 0
    var isEditingEnabled: Bool = true
    
    
    @IBOutlet var lineChart: LineChartView!
    @IBOutlet var graphicsView: UIVisualEffectView!
    @IBOutlet var configurationView: UIVisualEffectView!
    @IBOutlet var laboratoryARView: ARSCNView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.laboratoryARView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        laboratoryARView.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.laboratoryARView.session.run(configuration)
        self.navigationController?.isNavigationBarHidden = true
        updateGraph()
        wilberForcePendulum.calculateParametrsOfTheSystem()
        graphicsBtn.isEnabled = false
        configurationBtn.isEnabled = false
        z_beginLabel.text = "\(wilberForcePendulum.z_begin * 100) см"
        thetaBeginlabel.text = "\(wilberForcePendulum.theta_begin) радиан"
        loadMassLabel.text = "\(wilberForcePendulum.load_mass * 1000) гр"
        nutMassLabel.text = "\(wilberForcePendulum.nut_mass * 1000) гр"
        rigidityCofLabel.text = "\(wilberForcePendulum.rigidity_cof) кг/с"
        disableAllSliders()
    }
    
    
    @IBAction func resetSessionBtnWasPressed(_ sender: Any) {
        isExperimentPlaing = false
        if !graphicsView.isHidden {
            graphicsView.isHidden = true
        }
        if !configurationView.isHidden {
            configurationView.isHidden = true
        }
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.laboratoryARView.session.run(configuration, options: .resetTracking)
        self.laboratoryARView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        laboratoryARView.scene = SCNScene()
        wilberForcePendulum.resetParamethersOfTheSystem()
        updateGraph()
        dataArrayZ = []
        dataArrayTheta = []
        z_beginLabel.text = "\(wilberForcePendulum.z_begin * 100) см"
        zBeginSlider.value = Float(wilberForcePendulum.z_begin)
        thetaBeginlabel.text = "\(wilberForcePendulum.theta_begin) радиан"
        thetaBeginSlider.value = Float(wilberForcePendulum.theta_begin)
        loadMassLabel.text = "\(wilberForcePendulum.load_mass * 1000) гр"
        loadMassslider.value = Float(wilberForcePendulum.load_mass)
        nutMassLabel.text = "\(wilberForcePendulum.nut_mass * 1000) гр"
        nutMassSlider.value = Float(wilberForcePendulum.nut_mass)
        rigidityCofLabel.text = "\(wilberForcePendulum.rigidity_cof) кг/с"
        rigidityCofSlider.value = Float(wilberForcePendulum.rigidity_cof)
        wilberForcePendulum.calculateParametrsOfTheSystem()
        updateGraph()
        graphicsBtn.isEnabled = false
        configurationBtn.isEnabled = false
        t = 0
        isEditingEnabled = true
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
        lineChart.data = wilberForcePendulum.updateCharts()
        lineChart.chartDescription?.text = "dfjgfdjgkhj"
        lineChart.backgroundColor = UIColor.white
    }
    
    
    @IBAction func startExperimentBtnWasPressed(_ sender: Any) {
        let startButton = sender as! UIButton
        startButton.setImage(UIImage(named: "pause"), for: .normal)
        wilberForcePendulum.calculateParametrsOfTheSystem()
        disableAllSliders()
        isExperimentPlaing = !isExperimentPlaing
    }
    
    @IBAction func stopExperimentBtnWasPressed(_ sender: Any) {
        isExperimentPlaing = false
        wilberForcePendulum.resetParamethersOfTheSystem()
        updateGraph()
        dataArrayZ = []
        dataArrayTheta = []
        z_beginLabel.text = "\(wilberForcePendulum.z_begin * 100) см"
        zBeginSlider.value = Float(wilberForcePendulum.z_begin)
        thetaBeginlabel.text = "\(wilberForcePendulum.theta_begin) радиан"
        thetaBeginSlider.value = Float(wilberForcePendulum.theta_begin)
        loadMassLabel.text = "\(wilberForcePendulum.load_mass * 1000) гр"
        loadMassslider.value = Float(wilberForcePendulum.load_mass)
        nutMassLabel.text = "\(wilberForcePendulum.nut_mass * 1000) гр"
        nutMassSlider.value = Float(wilberForcePendulum.nut_mass)
        rigidityCofLabel.text = "\(wilberForcePendulum.rigidity_cof) кг/с"
        rigidityCofSlider.value = Float(wilberForcePendulum.rigidity_cof)
        wilberForcePendulum.calculateParametrsOfTheSystem()
        updateGraph()
        t = 0
        enableAllsliders()
    }
    
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if isExperimentPlaing {
            let position = wilberForcePendulum.changePositionOntime(t: t)
            let z = position.0
            let theta = position.1
            wilberForcePendulum.updateZPosition(z: z)
            wilberForcePendulum.updateThetaRotation(theta: theta)
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
    

    
    //Добавить функцию увеличения и поворота
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEditingEnabled == true {
            guard let touch = touches.first else { return }
            let result = laboratoryARView.hitTest(touch.location(in: laboratoryARView), types: [ARHitTestResult.ResultType.featurePoint])
            guard let hitResult = result.last else { return }
            let hitTransform = SCNMatrix4(hitResult.worldTransform)
            let hitvector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
            laboratoryARView.scene = wilberForcePendulum.setupSceneOnTouch(hitVector: hitvector)
            self.laboratoryARView.debugOptions = []
            isEditingEnabled = false
            configurationBtn.isEnabled = true
            graphicsBtn.isEnabled = true
            enableAllsliders()
        }
    }
    
    
    @IBAction func zBeginSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        wilberForcePendulum.z_begin = Double(slider.value).rounded(toPlaces: 4)
        wilberForcePendulum.updateZPosition(z: wilberForcePendulum.z_begin)
        z_beginLabel.text = "\(wilberForcePendulum.z_begin * 100) см"
        
    }
    
    
    @IBAction func thetaBeginSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        wilberForcePendulum.theta_begin = Double(slider.value).rounded(toPlaces: 4)
        wilberForcePendulum.updateThetaRotation(theta: wilberForcePendulum.theta_begin)
        thetaBeginlabel.text = "\(wilberForcePendulum.theta_begin) радиан"
    }
    

    @IBAction func loadMassSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        wilberForcePendulum.load_mass = Double(slider.value).rounded(toPlaces: 4)
        loadMassLabel.text = "\(wilberForcePendulum.load_mass * 1000) гр"
    }
    
    @IBAction func nutMassSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        wilberForcePendulum.nut_mass = Double(slider.value).rounded(toPlaces: 4)
        nutMassLabel.text = "\(wilberForcePendulum.nut_mass * 1000) гр"
    }
    
    
    @IBAction func rigidityCofSliderWasChanged(_ sender: Any) {
        let slider = sender as! UISlider
        wilberForcePendulum.rigidity_cof = Double(slider.value).rounded(toPlaces: 4)
        rigidityCofLabel.text = "\(wilberForcePendulum.rigidity_cof) кг/с"
    }
    
}
