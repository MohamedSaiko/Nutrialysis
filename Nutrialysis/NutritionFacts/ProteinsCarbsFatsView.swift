//
//  ProteinsCarbsFatsView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 14.05.24.
//

import SwiftUI

struct ProteinsCarbsFatsView: View {
    private let totalProteins: Int
    private let totalCarbs: Int
    private let totalFats: Int
    
    init(totalProteins: Int, totalCarbs: Int, totalFats: Int) {
        self.totalProteins = totalProteins
        self.totalCarbs = totalCarbs
        self.totalFats = totalFats
    }
    
    var body: some View {
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
    }
}
