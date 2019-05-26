//
//  AboutLaboratoryVC.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 22/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import UIKit

class AboutLaboratoryVC: UIViewController {
    
    @IBOutlet var laboratoryCoverImage: UIImageView!
    
    @IBOutlet var laboratoryDescription: UITextView!
    
    @IBOutlet var mathematicalModelImage: UIImageView!
    
    @IBOutlet var laboratoryConfiguration: UITextView!
    
    @IBOutlet var lookIn3DBtn: RoundedButtonView!
    
    @IBOutlet var lookInARBtn: RoundedButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = laboratoriesClasses[selectedCell].nameOfTheLaboratory
        laboratoryDescription.text = laboratoriesClasses[selectedCell].descriptionOfTheLaboratory
        laboratoryCoverImage.image = UIImage(named: laboratoriesClasses[selectedCell].laboratoryCoverImage)
        mathematicalModelImage.image = UIImage(named: laboratoriesClasses[selectedCell].mathematicalModelImage)
        laboratoryConfiguration.attributedText = laboratoriesClasses[selectedCell].configurationOfLaboratory
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    
    @IBAction func btnWaspressed(_ sender: RoundedButtonView) {
        sender.onTapAnimation()
    }
    
    
    
    @IBAction func btnWasReleased(_ sender: RoundedButtonView) {
        sender.onReleaseAnimation()
        
    }
    
    


}
