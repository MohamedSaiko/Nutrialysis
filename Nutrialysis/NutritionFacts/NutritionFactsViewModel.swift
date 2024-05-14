//
//  NutritionFactsViewModel.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 26.04.24.
//

import Foundation

enum Nutrient {
    case calories
    case proteins
    case fats
    case carbs
    case saturatedFat
    case cholesterol
    case sodium
    case dietaryFiber
    case sugars
    case potassium
}

final class NutritionFactsViewModel: ObservableObject {
    private let networkManager: NetworkManager
    
    @Published private var nutrients: FoodNutrients
    @Published private var altMeasures =  [AltMeasure]()
    @Published var measures = [String]()
    @Published var quantities = [Int]()
    @Published var measureSelection: String = ""
    @Published var quantitySelection: Int = 1
    @Published var totalCalories: Int = 0
    @Published var totalProteins: Int = 0
    @Published var totalCarbs: Int = 0
    @Published var totalFats: Int = 0
    @Published var saturatedFat: Int = 0
    @Published var cholesterol: Int = 0
    @Published var sodium: Int = 0
    @Published var dietaryFiber: Int = 0
    @Published var sugars: Int = 0
    @Published var potassium: Int = 0
    
    var photo: URL {
        showNutrients().photo.highres
    }
    
    init(networkManager: NetworkManager, nutrients: FoodNutrients) {
        self.networkManager = networkManager
        self.nutrients = nutrients
    }
    
    func getNutrients(withfoodName name: String) {
        networkManager.sendFoodName(foodName: name) { [weak self] (result: Result<Nutrients,NetworkError>) in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let nutrients):
                DispatchQueue.main.async {
                    self.addNutrients(foodNutrients: nutrients.foods)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func addNutrients(foodNutrients: [FoodNutrients]) {
        nutrients = foodNutrients[0]
        altMeasures = foodNutrients[0].altMeasures
        for altMeasure in altMeasures {
            measures.append(altMeasure.measure)
        }
        
        for quantity in 1...100 {
            quantities.append(quantity)
        }
        
        measureSelection = nutrients.servingUnit
        quantitySelection = Int(nutrients.servingQty ?? 1)
    }
    
    private func showNutrients() -> FoodNutrients {
        return nutrients
    }
    
    private func getPickerIndex() -> Int {
        guard let index = measures.firstIndex(of: measureSelection) else {
            return Int()
        }
        return index
    }
    
    private func calculate(nutrient: Nutrient) {
        var type: Double? = nil
        
        switch nutrient {
        case .calories:
            type = nutrients.nfCalories
        case .proteins:
            type = nutrients.nfProtein
        case .fats:
            type = nutrients.nfTotalFat
        case .carbs:
            type = nutrients.nfTotalCarbohydrate
        case .saturatedFat:
            type = nutrients.nfSaturatedFat
        case .cholesterol:
            type = nutrients.nfCholesterol
        case .sodium:
            type = nutrients.nfSodium
        case .dietaryFiber:
            type = nutrients.nfDietaryFiber
        case .sugars:
            type = nutrients.nfSugars
        case .potassium:
            type = nutrients.nfPotassium
        }
        
        guard let type = type , let defaultServingWeight =  nutrients.servingWeightGrams else {
            return
        }
        
        let index = getPickerIndex()
        let servingWeight = altMeasures[index].servingWeight
        let defaultQuantity = altMeasures[index].qty
        let typePerServing = (type/Double(defaultQuantity)) * (servingWeight/defaultServingWeight)
        let doubleTotalOfItem = Double(quantitySelection) * typePerServing
        
        switch nutrient {
        case .calories:
            totalCalories = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .proteins:
            totalProteins = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .fats:
            totalFats = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .carbs:
            totalCarbs = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .saturatedFat:
            saturatedFat = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .cholesterol:
            cholesterol = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .sodium:
            sodium = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .dietaryFiber:
            dietaryFiber = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .sugars:
            sugars = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        case .potassium:
            potassium = Int(doubleTotalOfItem.rounded(.toNearestOrAwayFromZero))
        }
    }
    
    func showTotalNutrients() {
        calculate(nutrient: .calories)
        calculate(nutrient: .proteins)
        calculate(nutrient: .fats)
        calculate(nutrient: .carbs)
        calculate(nutrient: .saturatedFat)
        calculate(nutrient: .cholesterol)
        calculate(nutrient: .sodium)
        calculate(nutrient: .dietaryFiber)
        calculate(nutrient: .sugars)
        calculate(nutrient: .potassium)
    }
}
