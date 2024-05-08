//
//  CartView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var userPurchase: UserPurchase
    @State var showBuyAlert = false
    @State var showErrorAlert = false
    
    var body: some View {
        VStack {
            Text("Selected tariff:")
                .font(.title3)
                .bold()
                .padding()
            Text(userPurchase.tariff.name)
                .font(.title)
                .bold()
                .padding()
            Text("\(userPurchase.tariff.price) RUB")
                .font(.title)
                .bold()
            
            Button(action: {
                    showBuyAlert.toggle()
            }, label: {
                Text("Buy")
                    .frame(width: 100, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .alert(isPresented: $showBuyAlert, content: {
                if userPurchase.tariff.price != 0 {
                    return Alert(title: Text("Thank you for purchase!"), message: Text("You bought Tariff: \(userPurchase.tariff.name) for \(userPurchase.tariff.price) RUB"), dismissButton: .default(Text("Close")))
                } else {
                    return Alert(title: Text("Error"), message: Text("You should choose Tariff first"), dismissButton: .default(Text("Close")))
                }
            })
        }
    }
}
