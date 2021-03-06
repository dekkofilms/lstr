//
//  SingleBorderBottom.swift
//  lstr
//
//  Created by Taylor King on 12/12/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit

class SingleBorderBottom: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //rgba(236, 240, 241,1.0)
        self.setValue(UIColor.init(colorLiteralRed: 236/255, green: 240/255, blue: 241/255, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
    }

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
