//
//  CaloriesView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 14.05.24.
//

import SwiftUI

struct CaloriesView: View {
    private let totalCalories: Int
    
    init(totalCalories: Int) {
        self.totalCalories = totalCalories
    }
    
    var body: some View {
        HStack {
            Text("Calories")
            
            Spacer()
            
            Text(String(totalCalories) + " cal")
        }
    }
}
