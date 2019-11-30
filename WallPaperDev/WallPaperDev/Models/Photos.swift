//
//  Photos.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

struct NewPhotos: Codable {
    let total, totalPages: Int
    let results: [NewResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct NewResult: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
