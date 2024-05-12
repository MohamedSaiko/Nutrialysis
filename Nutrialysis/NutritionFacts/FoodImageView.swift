//
//  FoodImageView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 09.05.24.
//

import SwiftUI

struct FoodImageView: View {
    private let imageURL: URL
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .center)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(minHeight: UIScreen.main.bounds.size.height/3)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .listRowSeparator(.hidden)
    }
}
