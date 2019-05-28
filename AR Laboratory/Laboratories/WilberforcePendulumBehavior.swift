//
//  File.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 23/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import Foundation
import SceneKit
import Charts


class WilberforcePendulumBehavior {
    
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
    private(set) var spoke_mass: Double = 0.025
    //Общая масса
    private(set) var full_mass: Double = 0.34
    
    private(set) var I: Double = 1
    
    private(set) var epsilon: Double = 1
    
    private(set) var omega_z: Double = 1
    
    private(set) var omega_theta: Double = 1
    
    private(set) var w1: Double = 1
    
    private(set) var w2: Double = 1
    
    private(set) var wilberforceScene: SCNScene = SCNScene(named: "LaboratoriesModels.scnassets/WilberforcePendulum/Wilberforce.scn")!
    
    private(set) var currentPendulum: SCNNode = SCNNode()
    private(set) var springTopNode: SCNNode = SCNNode()
    private(set) var springNode: SCNNode = SCNNode()
    private(set) var loadNode: SCNNode = SCNNode()
    
    
    func calculateParametrsOfTheSystem() {
        full_mass = load_mass + 4 * nut_mass + 4 * spoke_mass
        I = (load_mass * pow(0.01, 2.0) / 2) + (spoke_mass/3) * (3 * pow(0.001, 2.0) + pow(0.03, 2.0)) + nut_mass*(pow(0.004, 2.0) + pow(0.001, 2.0)) + 4*pow(0.02, 2.0)*(nut_mass + spoke_mass)
        epsilon = rigidity_cof * 0.23 * 0.005 * sin(Double.pi*79/180)
        omega_theta = rigidity_cof / full_mass
        omega_z = rigidity_cof / full_mass
        w1 = sqrt(omega_z + sqrt(pow(epsilon, 2.0) / (load_mass * I * 4)))
        w2 = sqrt(omega_z - sqrt(pow(epsilon, 2.0) / (load_mass * I * 4)))
    }
    
    //Убрать в класс маятника
    func changePositionOntime(t: Double) -> (Double, Double) {
        let z_position = z_begin / (pow(w1, 2.0) - pow(w2, 2.0)) * ((pow(w1, 2.0) - omega_theta)*cos(w1*t) - (pow(w2, 2) - omega_theta)*cos(w2*t)) - (2 * I * theta_begin / epsilon) / (pow(w1, 2.0) - pow(w2, 2.0)) * (pow(w1, 2.0) - omega_theta) * (pow(w2, 2.0) - omega_theta) * (cos(w1*t) - cos(w2*t))
        let theta_position = (epsilon * z_begin / 2 / I) / (pow(w1, 2.0) - pow(w2, 2.0)) * (cos(w1*t) - cos(w2*t)) + theta_begin / (pow(w1, 2.0) - pow(w2, 2.0))*((pow(w1, 2.0) - omega_theta) * cos(w2*t) - (pow(w2, 2.0) - omega_theta) * cos(w1*t))
        return (z_position, theta_position)
    }
    
    
    private func updateSpringPosition() {
        let k = (springTopNode.position.y - springNode.position.y) / 0.16
        springNode.scale.y = k
    }
    
    
    func updateZPosition(z: Double) {
        self.loadNode.position.y = Float(z)
        self.springNode.position.y = 0.236 + Float(z)
        updateSpringPosition()
    }
    
    
    func updateThetaRotation(theta: Double) {
        self.loadNode.eulerAngles.y = Float(theta)
    }
    
    
    
    func updateCharts() -> LineChartData {
        var lineChartEntry = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        for i in 0..<dataArrayZ.count {
            let value = ChartDataEntry(x: 0.1 * Double(i), y: dataArrayZ[i])
            lineChartEntry.append(value)
            let value2 = ChartDataEntry(x: 0.1 * Double(i), y: dataArrayTheta[i])
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
        return data
    }
    
    
    
    func setupSceneOnTouch(hitVector: SCNVector3) -> SCNScene {
        let newScene = SCNScene(named: Laboratories.shared.listOfLaboratories[selectedCell].laboratoryModel)!
        currentPendulum = newScene.rootNode.childNode(withName: "Wilberforce_Pendulum", recursively: false)!
        springTopNode = newScene.rootNode.childNode(withName: "Spring_Node_Top", recursively: true)!
        springNode = newScene.rootNode.childNode(withName: "Spring_node", recursively: true)!
        loadNode = newScene.rootNode.childNode(withName: "Load_Node", recursively: true)!
        currentPendulum.position = hitVector
        return newScene
    }
    
    
    func resetParamethersOfTheSystem() {
        z_begin = 0
        theta_begin = 0
        load_mass = 0.2
        nut_mass = 0.01
        rigidity_cof = 2
        updateThetaRotation(theta: theta_begin)
        updateZPosition(z: z_begin)
        dataArrayZ = [0]
        dataArrayTheta = [0]
    }

    

    
}






