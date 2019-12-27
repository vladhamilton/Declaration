//
//  Page.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

struct Page: Codable {
    let currentPage: Int
    let batchSize: Int
    let totalItems: String
    
    enum CodingKeys: String, CodingKey {
        case currentPage
        case batchSize
        case totalItems
    }
}
