//
//  AddedFoodView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct AddedFoodView: View {
    private let consumedDates: [String]
    private let caloriesPerDay: [String]
    private let foodEntities: [FoodEntity]
    
    private let getIndex: (String) -> Int
    private let deleteFood: (IndexSet) -> Void
    
    init(consumedDates: [String], caloriesPerDay: [String], foodEntities: [FoodEntity], getIndex: @escaping (String) -> Int, deleteFood: @escaping (IndexSet) -> Void) {
        self.consumedDates = consumedDates
        self.caloriesPerDay = caloriesPerDay
        self.foodEntities = foodEntities
        self.getIndex = getIndex
        self.deleteFood = deleteFood
    }
    
    var body: some View {
        List {
            ForEach(consumedDates, id: \.self) { date in
                Section(date) {
                    if !caloriesPerDay.isEmpty {
                        HStack {
                            Text("Total Calories Per Day: ")
                            
                            Spacer()
                            
                            Text(caloriesPerDay[getIndex(date)] + " cal")
                        }
                        .listRowSeparator(.visible)
                    }
                    
                    ForEach(foodEntities) { foodEntity in
                        if foodEntity.consumedDate?.formatted(date: .abbreviated, time: .omitted) == date {
                            HStack {
                                ImageView(imageURL: foodEntity.photo ?? URL(fileURLWithPath: String()))
                                
                                Text(String(foodEntity.quantity) + "x ")
                                
                                Text(foodEntity.measure ?? "")
                                
                                Spacer()
                                
                                Text(foodEntity.name ?? "no food")
                                
                                Spacer()
                                
                                Text(String(foodEntity.calories) + " cal")
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
            }
        }
        .listStyle(.grouped)
    }
}
