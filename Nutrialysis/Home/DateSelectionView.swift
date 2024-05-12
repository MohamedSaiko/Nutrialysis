//
//  DateSelectionView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct DateSelectionView: View {
    private let foodEntities: [FoodEntity]
    private let consumedDates: [String]
    private let proxy: ScrollViewProxy
    private let action: ([String], Date) -> Int
    
    @State private var selectedDate = Date.now
    
    init(foodEntities: [FoodEntity], consumedDates: [String], proxy: ScrollViewProxy, action: @escaping ([String], Date) -> Int) {
        self.foodEntities = foodEntities
        self.consumedDates = consumedDates
        self.proxy = proxy
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            DatePicker(selection: $selectedDate, in: (foodEntities.last?.consumedDate ?? Date())...Date.now, displayedComponents: .date) {
                Text("Select a date:")
            }
            .padding(.horizontal)
            
            Button {
                let index = action(consumedDates, selectedDate)
                proxy.scrollTo(consumedDates[index])
            } label: {
                HStack{
                    Text("Scroll")
                    Image(systemName: "arrow.down")
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: 125, maxHeight: 35, alignment: .center)
            .foregroundStyle(Color.black)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.trailing)
        }
    }
}
