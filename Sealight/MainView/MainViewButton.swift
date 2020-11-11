//
//  MainViewButton.swift
//  Sealight
//
//  Created by Gavin on 2020/8/8.
//  Copyright © 2020 Name. All rights reserved.
//

import UIKit

class MainViewButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
//        self.layer.cornerRadius = self.frame.width / 3

        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
