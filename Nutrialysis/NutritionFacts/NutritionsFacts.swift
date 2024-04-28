//
//  NutritionsFacts.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 28.04.24.
//

import Foundation

struct NutritionsFacts {
    let nutrients = FoodNutrients(foodName: String(), servingQty: Double(), servingUnit: String(), servingWeightGrams: Double(), nfCalories: Double(), nfTotalFat: Double(), nfSaturatedFat: Double(), nfCholesterol: Double(), nfSodium: Double(), nfTotalCarbohydrate: Double(), nfDietaryFiber: Double(), nfSugars: Double(), nfProtein: Double(), nfPotassium: Double(), altMeasures: [], photo: FoodPhoto(highres: URL(fileURLWithPath: String())))
}
