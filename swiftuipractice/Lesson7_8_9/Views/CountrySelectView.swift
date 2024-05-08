//
//  CountrySelectView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct CountrySelectView: View {
    @State private var isShowingImageList = false
    @State private var selectedImage: String? = "Germany"
    
    var body: some View {
        VStack {
            if let imageName = selectedImage {
                Image(imageName)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        isShowingImageList = true
                    }
            } else {
                Text("Tap to select an image")
                    .onTapGesture {
                        isShowingImageList = true
                    }
            }
        }
        .sheet(isPresented: $isShowingImageList) {
            CountryListView(selectedImage: $selectedImage, isShowingImageList: $isShowingImageList)
        }
    }
}
