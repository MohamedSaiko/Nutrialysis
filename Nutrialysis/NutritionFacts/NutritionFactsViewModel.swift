//
//  NutritionFactsViewModel.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 26.04.24.
//

import Foundation

final class NutritionFactsViewModel: ObservableObject {
    private let networkManager: NetworkManager
    
    @Published private var nutrients: FoodNutrients
    @Published private var altMeasures =  [AltMeasure]()
    @Published var measures = [String]()
    @Published var measureSelection: String = ""
    
    init(networkManager: NetworkManager, nutrients: FoodNutrients) {
        self.networkManager = networkManager
        self.nutrients = nutrients
    }
    
    func getNutrients(withfoodName name: String, completion: @escaping ([FoodNutrients]) -> Void) {
        networkManager.sendFoodName(foodName: name) { (result: Result<Nutrients,NetworkError>) in
            switch result {
            case .success(let nutrients):
                completion(nutrients.foods)
                
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
        measureSelection = nutrients.servingUnit
    }
    
    func showNutrients() -> FoodNutrients {
        return nutrients
    }
    
    private func getPickerIndex() -> Int {
        guard let index = measures.firstIndex(of: measureSelection) else {
            return Int()
        }
        return index
    }
    
    func calculate(quantity: Double) -> Double {
        guard let calories = nutrients.nfCalories , let servingWeight =  nutrients.servingWeightGrams else {
            return 0
        }
        
        let index = getPickerIndex()
        let caloriesPerGram = (calories/servingWeight)
        let totalCalories = (quantity * altMeasures[index].servingWeight * caloriesPerGram)
        
        return totalCalories
    }
}
