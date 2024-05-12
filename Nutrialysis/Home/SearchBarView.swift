//
//  SearchBarView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search Food", text: $searchText)
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
    }
}
