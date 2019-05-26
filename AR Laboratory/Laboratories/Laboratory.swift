//
//  File.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 23/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import Foundation


protocol LaboratoryRules {
    var nameOfTheLaboratory: String {get}
    var descriptionOfTheLaboratory: String {get}
    var laboratoryCoverImage: String {get}
    var mathematicalModelImage: String {get}
    var configurationOfLaboratory: NSAttributedString {get}
    func motion()
}

class Laboratory: LaboratoryRules {
    
    func motion() {
    }
    
    private(set) var nameOfTheLaboratory: String
    
    private(set) var descriptionOfTheLaboratory: String
    
    private(set) var laboratoryCoverImage: String
    
    private(set) var mathematicalModelImage: String
    
    private(set) var configurationOfLaboratory: NSAttributedString
    
    private(set) var laboratoryModel: String
    
    
    init(nameOfTheLaboratory: String, descriptionOfTheLaboratory: String, laboratoryCoverImage: String, mathematicalModelImage: String, configurationOfLaboratory: NSAttributedString, laboratoryModel: String) {
        
        self.nameOfTheLaboratory = nameOfTheLaboratory
        self.descriptionOfTheLaboratory = descriptionOfTheLaboratory
        self.laboratoryCoverImage = laboratoryCoverImage
        self.mathematicalModelImage = mathematicalModelImage
        self.configurationOfLaboratory = configurationOfLaboratory
        self.laboratoryModel = laboratoryModel
    }
    
    
    
    
}




