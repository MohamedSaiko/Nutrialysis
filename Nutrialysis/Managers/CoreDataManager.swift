//
//  CoreDataManager.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 28.04.24.
//

import Foundation
import CoreData

final class CoreDataManager: ObservableObject {
    private let container: NSPersistentContainer
    private var isFoodAdded = false
    
    @Published var foodEntities = [FoodEntity]()
    @Published var consumedDates = [String]()
    @Published var caloriesPerDay = [String]()
    
    init() {
        container = NSPersistentContainer(name: foodContainer)
        container.loadPersistentStores { (description, error) in
            guard let error = error else {
                return
            }
            
            print("Error Loading CoreData: \(error.localizedDescription)")
        }
        
        fetchFood()
    }
    
    func addNewFoodEntity(withfoodName name: String, calories: Int, quantity: Int, measure: String, photo: URL, completion: @escaping (Bool) -> Void) {
        let foodEntity = FoodEntity(context: container.viewContext)
        foodEntity.name = name
        foodEntity.calories = Int16(calories)
        foodEntity.quantity = Int16(quantity)
        foodEntity.measure = measure
        foodEntity.photo = photo
        foodEntity.consumedDate = .now
        
        saveData()
        completion(isFoodAdded)
    }
    
    private func fetchFood() {
        let request = NSFetchRequest<FoodEntity>(entityName: foodEntity)
        
        do {
            foodEntities = try container.viewContext.fetch(request).reversed()
            
            var dates = [Date]()
            
            for entity in foodEntities {
                guard let date = entity.consumedDate else {
                    return
                }
                
                dates.append(date)
            }
            
            let mappedDates = dates.map {
                $0.formatted(date: .abbreviated, time: .omitted)
            }
            
            for date in mappedDates {
                if !consumedDates.contains(date) {
                    consumedDates.append(date)
                }
            }
            
            caloriesPerDay.removeAll()
            for date in consumedDates {
                var resultArray = [Int16]()
                var sum: Int16 = 0
                
                for entity in foodEntities {
                    if entity.consumedDate?.formatted(date: .abbreviated, time: .omitted) == date {
                        
                        resultArray.append(entity.calories)
                        sum = resultArray.reduce(0, +)
                    }
                }
                caloriesPerDay.append(String(sum))
            }
        } catch let error {
            print("Error Fetching FoodEntities: \(error.localizedDescription)")
        }
    }
    
    func deleteFood(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        
        let foodEntity = foodEntities[index]
        container.viewContext.delete(foodEntity)
        saveData()
    }
    
    func deleteFood() {
        guard let foodEntity = foodEntities.first else {
            return
        }
        
        container.viewContext.delete(foodEntity)
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            consumedDates.removeAll()
            fetchFood()
            isFoodAdded = true
        } catch let error {
            print("Error Saving To CoreData: \(error.localizedDescription)")
        }
    }
    
    func getIndex(date: String) -> Int {
        return consumedDates.firstIndex(of: date) ?? Int()
    }
}
