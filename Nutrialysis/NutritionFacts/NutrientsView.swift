//
//  NutrientsView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct NutrientsView: View {
    private let totalCalories: Int
    private let totalProteins: Int
    private let totalCarbs: Int
    private let totalFats: Int
    private let dietaryFiber: Int
    private let sugars: Int
    private let cholesterol: Int
    private let saturatedFat: Int
    private let sodium: Int
    private let potassium: Int
    
    init(totalCalories: Int, totalProteins: Int, totalCarbs: Int, totalFats: Int, dietaryFiber: Int, sugars: Int, cholesterol: Int, saturatedFat: Int, sodium: Int, potassium: Int) {
        self.totalCalories = totalCalories
        self.totalProteins = totalProteins
        self.totalCarbs = totalCarbs
        self.totalFats = totalFats
        self.dietaryFiber = dietaryFiber
        self.sugars = sugars
        self.cholesterol = cholesterol
        self.saturatedFat = saturatedFat
        self.sodium = sodium
        self.potassium = potassium
    }
    
    var body: some View {
        HStack {
            Text("Calories")
            
            Spacer()
            
            Text(String(totalCalories) + " cal")
        }
        
        HStack {
            Text("Proteins")
            
            Spacer()
            
            Text(String(totalProteins) + " g")
            
            Divider()
            
            Text("Carbs")
            
            Spacer()
            
            Text(String(totalCarbs) + " g")
            
            Divider()
            
            Text("Fats")
            
            Spacer()
            
            Text(String(totalFats) + " g")
        }
        
        HStack {
            Text("Fibers")
            
            Spacer()
            
            Text(String(dietaryFiber) + " g")
            
            Divider()
            
            Text("Sugars")
            
            Spacer()
            
            Text(String(sugars) + " g")
        }
        
        HStack {
            Text("Cholesterol")
            
            Spacer()
            
            Text(String(cholesterol) + " g")
            
            Divider()
            
            Text("Saturated Fat")
            
            Spacer()
            
            Text(String(saturatedFat) + " g")
        }
        
        HStack {
            Text("Sodium")
            
            Spacer()
            
            Text(String(sodium) + " g")
            
            Divider()
            
            Text("Potassium")
            
            Spacer()
            
            Text(String(potassium) + " g")
        }
    }
}
