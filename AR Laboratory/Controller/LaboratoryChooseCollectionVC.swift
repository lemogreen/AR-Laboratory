//
//  ViewController.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 21/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import UIKit

class LaboratoryChooseCollectionVC: UICollectionViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Laboratories.shared.create_AllLaboratoryDescriptions()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Laboratories.shared.listOfLaboratories.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labCell", for: indexPath) as? VirtualLaboratoriesCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(laboratoryName: Laboratories.shared.listOfLaboratories[indexPath.row].nameOfTheLaboratory
            , image: Laboratories.shared.listOfLaboratories[indexPath.row].laboratoryCoverImage)
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        performSegue(withIdentifier: "toDetailVC", sender: nil)
        
        
    }
    

}





