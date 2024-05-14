//
//  FibersSugarsView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 14.05.24.
//

import SwiftUI

struct FibersSugarsView: View {
    private let dietaryFiber: Int
    private let sugars: Int
    
    init(dietaryFiber: Int, sugars: Int) {
        self.dietaryFiber = dietaryFiber
        self.sugars = sugars
    }
    
    var body: some View {
        HStack {
            Text("Fibers")
            
            Spacer()
            
            Text(String(dietaryFiber) + " g")
            
            Divider()
            
            Text("Sugars")
            
            Spacer()
            
            Text(String(sugars) + " g")
        }
    }
}
