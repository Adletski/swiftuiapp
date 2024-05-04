//
//  ContentView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    enum Constant {
        static let title = "Alert & ActionSheet"
        static let alertExample = "Пример Alert"
        static let show = "Показать"
    }
    
    @State private var isError = false
    @State private var text2 = "Пример Alert с 2 кнопками и логикой"
    @State private var actionSheet = false
    @State private var actionSheetText = "Пример ActionSheet с кнопками и логикой"
    @State private var actionSheet2 = false
    @State private var actionSheetText2 = "Пример ActionSheet с кнопками и логикой"
    
    var body: some View {
        mainView
    }
    
    private var mainView: some View {
        VStack(spacing: 60) {
            Text(Constant.title)
                .fontWeight(.bold)
            VStack(spacing: 20) {
                HStack {
                    Text(Constant.alertExample)
                    Spacer()
                    Button(Constant.show) {
                        print("show")
                    }
                    .standardButtonStyle()
                }
                HStack {
                    Text(text2)
                    Spacer()
                    Button {
                        self.isError = true
                    } label: {
                        Text(Constant.show)
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
                    .standardButtonStyle()
                }
                HStack {
                    Text("Пример ActionSheet")
                    Spacer()
                    Button {
                        self.actionSheet = true
                    } label: {
                        Text(Constant.show)
                    }.actionSheet(isPresented: $actionSheet, content: {
                        ActionSheet(title: Text("Show action sheet"))
                    })
                    .standardButtonStyle()
                }
                HStack {
                    Text("Пример ActionSheet с кнопками и логикой")
                    Spacer()
                    Button {
                        self.actionSheet2 = true
                    } label: {
                        Text(Constant.show)
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
                    .standardButtonStyle()
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct StandardButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 48)
            .background(.purple)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

extension View {
    func standardButtonStyle() -> some View {
        self.modifier(StandardButtonStyle())
    }
}

#Preview {
    ContentView()
}
