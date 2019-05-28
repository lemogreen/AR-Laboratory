//
//  Extentions.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 28/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import Foundation


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
