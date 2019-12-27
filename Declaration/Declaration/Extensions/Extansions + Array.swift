//
//  Extansions + Array.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
