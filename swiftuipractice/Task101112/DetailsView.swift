//
//  DetailsView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 08.05.2024.
//

import SwiftUI

struct DetailsView: View {
    @State var textEditor = ""
    @State var totalChars = 0
    @State var lastText = ""
    @Binding var showFullScreenModal: Bool
    
    var body: some View {
        ZStack {
            DetailsViewBackgroundGradient()
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                HStack {
                    Text("Sofa Elda 900").font(.title2).fontWeight(.bold)
                    Spacer()
                    Image("heart")
                }.padding()
                Image("sofa")
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.clear)
                        .background(BackgroundGradient())
                        .cornerRadius(30)
                    VStack {
                        HStack {
                            Text("Article: 283564").foregroundColor(.white)
                            Spacer()
                        }
                        Text("Description: A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design.").foregroundColor(.white)
                        Text("Review").foregroundColor(.white).fontWeight(.bold)
                        HStack {
                            Spacer()
                            ProgressView("Chars: \(totalChars)/300", value: Double(totalChars), total: 300).foregroundColor(.white)
                        }
                        TextEditor(text: $textEditor)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.white)
                            .onChange(of: textEditor) { text in
                                totalChars = text.count
                                if totalChars <= 300 {
                                    lastText = text
                                } else {
                                    textEditor = lastText
                                }
                            }
                        Button("Buy now") {
                            showFullScreenModal = false
                        }
                        .frame(width: 200, height: 55)
                        .background(.white)
                        .cornerRadius(25)
                        .offset(y: -30)
                        
                    }.padding()
                }
                Spacer()
            }
            .offset(y: 50)
        }
    }
}

struct DetailsViewBackgroundGradient: View {
    var body: some View {
        Color(.lightGray)
            .edgesIgnoringSafeArea(.all)
    }
}

//#Preview{
//    DetailsView()
//}
