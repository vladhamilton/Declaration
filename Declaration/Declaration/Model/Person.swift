//
//  Person.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

struct Person: Codable, Hashable {
    let id: String
    let firstname: String
    let lastname: String
    let placeOfWork: String
    let linkPDF: String?
    let position: String?
    var isFavorite: Bool? = false
    var comment: String?
    
}
