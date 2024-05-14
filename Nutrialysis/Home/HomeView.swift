//
//  HomeView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 24.04.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel(networkManager: NetworkManager())
    @EnvironmentObject var coreDataManager: CoreDataManager
    @FocusState private var isFocuced: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    SearchBarView(searchText: $homeViewModel.searchText)
                        .focused($isFocuced)
                    
                    if isFocuced {
                        withAnimation {
                            Button("Cancel") {
                                isFocuced = false
                                homeViewModel.searchText = ""
                                homeViewModel.removeAllFood()
                            }
                            .padding(.trailing)
                            .padding(.leading, -10)
                        }
                    }
                }
                
                if isFocuced {
                    withAnimation {
                        FoodSearchView(commonFoods: homeViewModel.getfood())
                    }
                    
                } else if coreDataManager.foodEntities.isEmpty {
                    ContentUnavailableView("Search Food", systemImage: "magnifyingglass", description: Text("You don't have any added Food yet."))
                    
                } else {
                    ScrollViewReader { proxy in
                        DateSelectionView(foodEntities: coreDataManager.foodEntities, consumedDates: coreDataManager.consumedDates, proxy: proxy, action: homeViewModel.scrollToSelecedDate)
                        
                        AddedFoodView(consumedDates: coreDataManager.consumedDates, caloriesPerDay: coreDataManager.caloriesPerDay, foodEntities: coreDataManager.foodEntities, getIndex: coreDataManager.getIndex, deleteFood: coreDataManager.deleteFood)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Nutrialysis")
            .onChange(of: homeViewModel.searchText) {
                homeViewModel.showFoodResults()
            }
            .onAppear {
                homeViewModel.searchText = ""
                homeViewModel.removeAllFood()
            }
        }
    }
}
