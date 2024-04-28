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
    private let foodName: String
    
    init(foodName: String) {
        self.foodName = foodName
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: nutritionFactsViewModel.showNutrients().photo.highres) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                
                Text(nutritionFactsViewModel.showNutrients().foodName)
                Text(nutritionFactsViewModel.showNutrients().nfCalories?.roundedTo(numberOfDecimals: 2, withString: "Calories") ?? "0")
                
                Picker("Measure", selection: $nutritionFactsViewModel.measureSelection) {
                    ForEach(nutritionFactsViewModel.measures, id: \.self) { measures in
                        Text(measures)
                    }
                }
                .pickerStyle(.menu)
                
                Text("you selected: \(nutritionFactsViewModel.measureSelection)")
                    .onChange(of: nutritionFactsViewModel.measureSelection) {
                        print(nutritionFactsViewModel.calculate(quantity: 2))
                    }
                Button("add") {
                    coreDataManager.addNewFoodEntity(withfoodName: foodName)
                }
                .onChange(of: coreDataManager.foodEntities) {
                    print(coreDataManager.foodEntities)
                }
                .onAppear {
                    nutritionFactsViewModel.getNutrients(withfoodName: foodName) { nutrients in
                        DispatchQueue.main.async {
                            nutritionFactsViewModel.addNutrients(foodNutrients: nutrients)
                        }
                    }
                }
            }
        }
    }
}
