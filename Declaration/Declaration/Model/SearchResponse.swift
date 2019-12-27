//
//  SearchResponse.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

struct SearchResponse: Codable {
    let page: Page
    let items: [Person]
    
    enum CodingKeys: String, CodingKey {
        case page
        case items
    }
}
