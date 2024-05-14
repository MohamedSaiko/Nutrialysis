//
//  FoodSearchView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct FoodSearchView: View {
    private let commonFoods: [CommonFood]
    
    init(commonFoods: [CommonFood]) {
        self.commonFoods = commonFoods
    }
    
    var body: some View {
        List(commonFoods, id:\.self) { food in
            NavigationLink() {
                NutritionFactsView(foodName: food.foodName)
            } label: {
                HStack {
                    AsyncImage(url: food.photo.thumb) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    Text("\(food.foodName)")
                }
            }
        }
        .listStyle(.inset)
        
        Image(nutritionixLogo)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 30)
    }
}
