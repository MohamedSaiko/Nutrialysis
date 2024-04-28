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
    @Published var foodEntities = [FoodEntity]()
    
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
    
    func fetchFood() {
        let request = NSFetchRequest<FoodEntity>(entityName: foodEntity)
        
        do {
            foodEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching FoodEntities: \(error.localizedDescription)")
        }
    }
    
    func addNewFoodEntity(withfoodName name: String) {
        let newFood = FoodEntity(context: container.viewContext)
        newFood.name = name
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchFood()
        } catch let error {
            print("Error Saving To CoreData: \(error.localizedDescription)")
        }
    }
}
