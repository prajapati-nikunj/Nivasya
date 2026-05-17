//
//  OptimizedImage.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct OptimizedImage: View {
    let url: String
    private let contentMode: ContentMode
    
    public init(url: String, contentMode: ContentMode = .fill) {
        self.url = url
        self.contentMode = contentMode
    }
    
    public var body: some View {
        Group {
            if url.hasPrefix("http") {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: contentMode)
                    case .failure:
                        Image(systemName: "house.fill")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Handle local assets
                Image(url)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.glassBorder, lineWidth: 0.5)
        )
    }
}
