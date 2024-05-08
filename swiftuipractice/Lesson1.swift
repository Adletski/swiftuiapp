//
//  ContentView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State var isError = false
    @State var text2 = "Пример Alert с 2 кнопками и логикой"
    @State var actionSheet = false
    @State var actionSheetText = "Пример ActionSheet с кнопками и логикой"
    @State var actionSheet2 = false
    @State var actionSheetText2 = "Пример ActionSheet с кнопками и логикой"
    
    var body: some View {
        VStack(spacing: 60) {
            Text("Alert & ActionSheet").fontWeight(.bold)
            HStack {
                Text("Пример Alert")
                Spacer()
                Button("Показать") {
                    print("show")
                }
                .frame(width: 150, height: 48)
                .background(.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            HStack {
                Text(text2)
                Spacer()
                Button {
                    self.isError = true
                } label: {
                    Text("Показать")
                }.alert(isPresented: $isError, content: {
                    Alert(
                        title: Text("Alert"),
                        message: Text("Some message"),
                        primaryButton: .destructive(Text("Cancel")) {
                            text2 = "cancel"
                        },
                        secondaryButton: .default(Text("OK")) {
                            text2 = "success"
                        })
                })
                .frame(width: 150, height: 48)
                .background(.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            HStack {
                Text("Пример ActionSheet")
                Spacer()
                Button {
                    self.actionSheet = true
                } label: {
                    Text("Показать")
                }.actionSheet(isPresented: $actionSheet, content: {
                    ActionSheet(title: Text("Show action sheet"))
                })
                .frame(width: 150, height: 48)
                .background(.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            HStack {
                Text("Пример ActionSheet с кнопками и логикой")
                Spacer()
                Button {
                    self.actionSheet2 = true
                } label: {
                    Text("Показать")
                }.actionSheet(isPresented: $actionSheet2, content: {
                    ActionSheet(
                        title: Text("Show action sheet 4 example"),
                        message: Text("Some message"),
                        buttons: [
                            .destructive(Text("Cancel"), action: {
                                actionSheetText2 = "cancel"
                            }),
                            .default(Text("OK"), action: {
                                actionSheetText2 = "success"
                            })
                        ]
                    )
                })
                .frame(width: 150, height: 48)
                .background(.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            Spacer()
        }.padding(16)
    }
}

#Preview {
    ContentView()
}
