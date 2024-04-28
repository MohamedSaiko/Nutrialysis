//
//  Food.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 24.04.24.
//

import Foundation

struct Food: Decodable {
    let common: [CommonFood]
}

struct CommonFood: Decodable, Hashable {
    let foodName: String
    let photo: Photo
}

struct Photo: Decodable, Hashable {
    let thumb: URL
}
