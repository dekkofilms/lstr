//
//  SingleBorderBottom.swift
//  lstr
//
//  Created by Taylor King on 12/12/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit

class SingleBorderBottom: UITextField {

    override func draw(_ rect: CGRect) {
        
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 2.0
        
        tintColor.setStroke()
        
        path.stroke()
        
    }

}
