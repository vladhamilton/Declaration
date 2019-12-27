//
//  ToggleButton.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    // MARK: - properties
    
    var isOn = false
    
    // MARK: - override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    // MARK: - public
    
    func initButton() {
        addTarget(self, action: #selector(ToggleButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        
        let image = bool ? UIImage(named: "Star_filled") : UIImage(named: "Star")
        setImage(image, for: .normal)
        
    }
}
