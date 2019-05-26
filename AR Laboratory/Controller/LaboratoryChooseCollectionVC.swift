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
        laboratoriesClasses.append(wilberforcePendulum)
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return laboratoriesClasses.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labCell", for: indexPath) as? VirtualLaboratoriesCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(laboratoryName: laboratoriesClasses[indexPath.row].nameOfTheLaboratory, image: laboratoriesClasses[indexPath.row].laboratoryCoverImage)
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        performSegue(withIdentifier: "toDetailVC", sender: nil)
        
        
    }
    

}

