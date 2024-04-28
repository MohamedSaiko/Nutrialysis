//
//  HomeViewModel.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 24.04.24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private let networkManager: NetworkManager
    
    @Published private var food = [CommonFood]()
    @Published var searchText = ""
    
    private var searchFood: String {
        searchText.lowercased()
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    private func getFilteredFoodResults(foodName: String, completion: @escaping (Food) -> Void) {
        let url = searchingURL + foodName
        
        networkManager.loadData(withURL: url) { (result: Result<Food,NetworkError>) in
            switch result {
            case .success(let data):
                completion(data)
                
            case .failure(let error):
                print(NetworkError.unknownError(error))
            }
        }
    }
    
    func showFoodResults(completion: @escaping (Food) -> Void) {
        if !searchText.isEmpty {
            getFilteredFoodResults(foodName: searchFood) { food in
                completion(food)
            }
        }
    }
    
    func addNewFood(food foodData: Food) {
        food.append(contentsOf: foodData.common)
    }
    
    func getfood() -> [CommonFood] {
        return food
    }
    
    func checkNoFood() -> Bool {
        return food.isEmpty
    }
    
    func removeAllFood() {
        food.removeAll()
    }
}
