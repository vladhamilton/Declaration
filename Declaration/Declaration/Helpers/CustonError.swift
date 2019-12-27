//
//  CustonError.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case somethingWrong
    case noConnection
    
    var message: String {
        switch self {
        case .noConnection:
            return "No Internet connection"
        default:
            return "Something went wrong, please try later"
        }
    }
}
