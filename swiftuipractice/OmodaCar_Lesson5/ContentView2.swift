//
//  ContentView2.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 04.05.2024.
//

import SwiftUI

/// Экран оформления заказа машины
struct ContentView2: View {
    
    @ObservedObject var viewModel = OrderScreenViewModel()
    
    var body: some View {
        ZStack {
            Color.lesson6Bg
                .edgesIgnoringSafeArea(.all)
           
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer().frame(width: 35)
                    Image("logo")
                    Spacer()
                    Button(action: {
                        viewModel.share()
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                            .foregroundColor(.white)
                    })
                    .frame(width: 20)
                    .padding(.trailing)
                    .sheet(isPresented: $viewModel.isShareActivityPresented, content: {
                        ActivityView(activityItems: ["Отправить данные о машине"])
                    })
                }
                Spacer()
                Image(viewModel.cars[viewModel.selection].carImageName)
                Spacer()
                
                Picker(selection: Binding(get: {
                    viewModel.selection
                }, set: { newValue in
                    viewModel.selection = newValue
                    print(newValue)
                })) {
                    ForEach(viewModel.cars.indices, id: \.self) {
                        Text(viewModel.cars[$0].carName).tag($0)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(.segmented)
                .background(.white)
                .cornerRadius(8)
                .padding()
                
                Spacer()

                OrderView(viewModel: viewModel, car: $viewModel.cars[viewModel.selection])
                    .padding(.bottom, -35)
            }
        }
    }
}

#Preview {
    ContentView2()
}
