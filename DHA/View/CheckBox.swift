//
//  CheckBox.swift
//  DHA
//
//  Created by Sayed Abdo on 12/5/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

        // Images
        let checkedImage = #imageLiteral(resourceName: "success")
        let uncheckedImage = #imageLiteral(resourceName: "check-box-empty")
    
        // Bool property
        var isChecked: Bool = false {
            didSet{
                if isChecked == true {
                    self.setImage(checkedImage, for: UIControlState.normal)
                } else {
                    self.setImage(uncheckedImage, for: UIControlState.normal)
                }
            }
        }
        
        override func awakeFromNib() {
            self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
            self.isChecked = false
        }
        
    @objc func buttonClicked(sender: UIButton) {
            if sender == self {
                isChecked = !isChecked
            }
        }
}


