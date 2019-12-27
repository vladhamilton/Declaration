//
//  Extensions + String.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
