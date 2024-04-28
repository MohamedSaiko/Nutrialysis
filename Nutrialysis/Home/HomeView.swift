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
                    TextField("Search Food", text: $homeViewModel.searchText)
                        .focused($isFocuced)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(.rect(cornerRadius: 8, style: .circular))
                        .padding(.horizontal)
                        .overlay(alignment: .leading) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 25)
                        }
                        .overlay(alignment: .trailing) {
                            Button("\(Image(systemName: "mic.fill"))") {
                                print("speak now ....")
                            }
                            .font(.system(size: 20))
                            .padding(.horizontal, 30)
                        }
                    
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
                        List(homeViewModel.getfood(), id:\.self) { food in
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
                    }
//                } else if homeViewModel.checkNoFood() {
//                    ContentUnavailableView("Search Food", systemImage: "magnifyingglass", description: Text("You don't have any added Food yet."))
                } else {
                    List(coreDataManager.foodEntities) { foodEntity in
                        Text(foodEntity.name ?? "no food")
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                homeViewModel.searchText = ""
                homeViewModel.removeAllFood()
            }
            .onChange(of: homeViewModel.searchText) {
                homeViewModel.showFoodResults { food in
                    DispatchQueue.main.async {
                        homeViewModel.removeAllFood()
                        homeViewModel.addNewFood(food: food)
                    }
                }
            }
        }
    }
}
