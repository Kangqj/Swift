//
//  SLabel.swift
//  Swift_Study
//
//  Created by james on 2022/2/14.
//

import UIKit

class SLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @objc func setDefaultText(text: String) {
        self.text = text
        self.textColor = UIColor.blue
        self.textAlignment = NSTextAlignment.center
    }

}
