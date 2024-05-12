//
//  ImageView.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 12.05.24.
//

import SwiftUI

struct ImageView: View {
    private let imageURL: URL
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 30, height: 30)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .listRowSeparator(.hidden)
    }
}
