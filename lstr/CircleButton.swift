//
//  CircleButton.swift
//  lstr
//
//  Created by Taylor King on 12/16/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
    }

}
