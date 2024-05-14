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
    
    func showFoodResults() {
        if !searchText.isEmpty {
            getFilteredFoodResults(foodName: searchFood) { [weak self] food in
                guard let self else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.removeAllFood()
                    self.addNewFood(food: food)
                }
            }
        }
    }
    
    func addNewFood(food foodData: Food) {
        food.append(contentsOf: foodData.common)
    }
    
    func getfood() -> [CommonFood] {
        return food
    }
    
    func removeAllFood() {
        food.removeAll()
    }
    
    func scrollToSelecedDate(consumedDates: [String], selectedDate: Date) -> Int {
        let date = selectedDate.formatted(date: .abbreviated, time: .omitted)
        var index = 0
        
        if consumedDates.contains(date) {
            index = consumedDates.firstIndex(of: date) ?? Int()
            return index
        } else {
            let calendar = Calendar.current
            let SelectedYear = calendar.component(.year, from: selectedDate)
            let SelectedMonth = calendar.component(.month, from: selectedDate)
            
            for day in 1...31 {
                let component = DateComponents(calendar: calendar, year: SelectedYear, month: SelectedMonth, day: day)
                let date = calendar.date(from: component)?.formatted(date: .abbreviated, time: .omitted)
                
                if consumedDates.contains(date ?? "") {
                    index = consumedDates.firstIndex(of: date ?? "") ?? Int()
                    return index
                }
            }
        }
        return Int()
    }
}
