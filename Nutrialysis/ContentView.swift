//
//  ContentView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 24.04.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coreDataManager = CoreDataManager()
    
    var body: some View {
        HomeView()
            .environmentObject(coreDataManager)
    }
}
