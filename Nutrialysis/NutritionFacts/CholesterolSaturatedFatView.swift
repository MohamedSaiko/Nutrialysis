//
//  CholesterolSaturatedFatView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 14.05.24.
//

import SwiftUI

struct CholesterolSaturatedFatView: View {
    private let cholesterol: Int
    private let saturatedFat: Int
    
    init(cholesterol: Int, saturatedFat: Int) {
        self.cholesterol = cholesterol
        self.saturatedFat = saturatedFat
    }
    
    var body: some View {
        HStack {
            Text("Cholesterol")
            
            Spacer()
            
            Text(String(cholesterol) + " g")
            
            Divider()
            
            Text("Saturated Fat")
            
            Spacer()
            
            Text(String(saturatedFat) + " g")
        }
    }
}
