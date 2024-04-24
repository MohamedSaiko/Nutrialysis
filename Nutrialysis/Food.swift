//
//  Food.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 24.04.24.
//

import Foundation

struct Food: Decodable {
    let common: [Results]
}

struct Results: Decodable {
    let foodName: String
}

enum CodingKeys: String, CodingKey {
    case foodName = "food_name"
}
