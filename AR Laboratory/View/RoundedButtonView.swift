//
//  RoundedButtonView.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 22/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButtonView: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {layer.cornerRadius = newValue}
        get {return layer.cornerRadius}
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


extension RoundedButtonView {
    
    func onTapAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    func onReleaseAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }, completion: nil)
    }
    
}


class RoundedVisualEffectView : UIVisualEffectView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMaskLayer()
    }
    
    func updateMaskLayer(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        self.layer.mask = shapeLayer
    }
}

