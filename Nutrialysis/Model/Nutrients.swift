//
//  FoodNutrients.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 25.04.24.
//

import Foundation

struct Nutrients: Decodable {
    let foods: [FoodNutrients]
}

struct FoodNutrients: Decodable {
    let foodName: String
    let servingQty: Double?
    let servingUnit: String
    let servingWeightGrams: Double?
    let nfCalories: Double?
    let nfTotalFat: Double?
    let nfSaturatedFat: Double?
    let nfCholesterol: Double?
    let nfSodium: Double?
    let nfTotalCarbohydrate: Double?
    let nfDietaryFiber: Double?
    let nfSugars: Double?
    let nfProtein: Double?
    let nfPotassium: Double?
    let altMeasures: [AltMeasure]
    let photo: FoodPhoto
}

struct AltMeasure: Decodable, Hashable {
    let servingWeight: Double
    let measure: String
    let qty: Int
}

struct FoodPhoto: Decodable {
    let highres: URL
}
