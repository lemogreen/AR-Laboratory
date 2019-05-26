//
//  VirtualLaboratoriesCollectionCell.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 21/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import UIKit

@IBDesignable class VirtualLaboratoriesCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet var laboratoryCoverImage: UIImageView!
    
    @IBOutlet var laboratoryName: UILabel!
    
    
    @IBInspectable var cornerRadius: CGFloat {
        set {layer.cornerRadius = newValue}
        get {return layer.cornerRadius}
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {layer.borderWidth = newValue}
        get {return layer.borderWidth}
    }
    
    
    func setupCell(laboratoryName: String, image: String) {
        self.laboratoryName.text = laboratoryName
        self.laboratoryCoverImage.image = UIImage(named: image)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 15.0
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }
    
}
