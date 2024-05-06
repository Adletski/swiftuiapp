//
//  CountryListView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct CountryListView: View {
    @Binding var selectedImage: String?
    @Binding var isShowingImageList: Bool
    
    let images = ["Germany", "UK", "Russia", "US"]
    
    var body: some View {
        NavigationView {
            List(images, id: \.self) { imageName in
                Button(action: {
                    selectedImage = imageName
                    isShowingImageList = false
                }) {
                    Text("\(imageName)")
                }
            }
            .navigationTitle("Select Country")
            .navigationBarItems(trailing:
                Button("Close") {
                    isShowingImageList = false
                }
            )
        }
    }
}
