//
//  SodiumPotassiumView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct SodiumPotassiumView: View {
    private let sodium: Int
    private let potassium: Int
    
    init(sodium: Int, potassium: Int) {
        self.sodium = sodium
        self.potassium = potassium
    }
    
    var body: some View {
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
