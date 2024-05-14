//
//  NutrionalFactsView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 26.04.24.
//

import SwiftUI

struct NutritionFactsView: View {
    @StateObject private var nutritionFactsViewModel = NutritionFactsViewModel(networkManager: NetworkManager(), nutrients: NutritionsFacts().nutrients)
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @State private var isAdded = false
    @State private var numberofAddedItems = 0
    
    private let foodName: String
    
    init(foodName: String) {
        self.foodName = foodName
    }
    
    var body: some View {
        List {
            FoodImageView(imageURL: nutritionFactsViewModel.photo)
            
            Picker("Quantity", selection: $nutritionFactsViewModel.quantitySelection) {
                ForEach(nutritionFactsViewModel.quantities, id: \.self) { quantity in
                    Text("\(quantity)")
                }
            }
            .pickerStyle(.menu)
            
            Picker("Measure", selection: $nutritionFactsViewModel.measureSelection) {
                ForEach(nutritionFactsViewModel.measures, id: \.self) { measure in
                    Text(measure)
                }
            }
            .pickerStyle(.menu)
            
            CaloriesView(totalCalories: nutritionFactsViewModel.totalCalories)
            
            ProteinsCarbsFatsView(totalProteins: nutritionFactsViewModel.totalProteins, totalCarbs: nutritionFactsViewModel.totalCarbs, totalFats: nutritionFactsViewModel.totalFats)
            
            FibersSugarsView(dietaryFiber: nutritionFactsViewModel.dietaryFiber, sugars: nutritionFactsViewModel.sugars)
            
            CholesterolSaturatedFatView(cholesterol: nutritionFactsViewModel.cholesterol, saturatedFat: nutritionFactsViewModel.saturatedFat)
            
            SodiumPotassiumView(sodium: nutritionFactsViewModel.sodium, potassium: nutritionFactsViewModel.potassium)
        }
        .listStyle(.plain)
        
        VStack {
            if isAdded {
                Text("\(Image(systemName: "checkmark.circle.fill")) \(numberofAddedItems) Item\(numberofAddedItems > 1 ? "s": "" ) Added to Calories Balance Sheet. ")
                    .foregroundStyle(Color.green)
            }
            
            HStack {
                Button {
                    coreDataManager.deleteFood()
                    numberofAddedItems -= nutritionFactsViewModel.quantitySelection
                    if numberofAddedItems == 0 {
                        isAdded = false
                    }
                } label: {
                    HStack {
                        HStack(spacing: 5){
                            Image(systemName: "minus.circle")
                            
                            Text("Delete")
                        }
                    }
                }
                .disabled(!isAdded)
                .frame(maxWidth: UIScreen.main.bounds.size.width/2, maxHeight: 40, alignment: .center)
                .foregroundStyle(Color.black)
                .background(!isAdded ? .gray.opacity(0.3) : .red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    coreDataManager.addNewFoodEntity(withfoodName: foodName, calories: nutritionFactsViewModel.totalCalories, quantity: nutritionFactsViewModel.quantitySelection, measure: nutritionFactsViewModel.measureSelection, photo: nutritionFactsViewModel.photo) { result in
                        isAdded = result
                        numberofAddedItems += nutritionFactsViewModel.quantitySelection
                    }
                } label: {
                    HStack {
                        HStack(spacing: 5){
                            Image(systemName: "plus.circle")
                            
                            Text("Add")
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Text(String(nutritionFactsViewModel.quantitySelection))
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.size.width/2, maxHeight: 40, alignment: .center)
                .foregroundStyle(Color.black)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        .navigationTitle(foodName.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: nutritionFactsViewModel.measureSelection) {
            nutritionFactsViewModel.showTotalNutrients()
            isAdded = false
        }
        .onChange(of: nutritionFactsViewModel.quantitySelection) {
            nutritionFactsViewModel.showTotalNutrients()
            isAdded = false
        }
        .onAppear {
            isAdded = false
            nutritionFactsViewModel.getNutrients(withfoodName: foodName)
        }
    }
}
