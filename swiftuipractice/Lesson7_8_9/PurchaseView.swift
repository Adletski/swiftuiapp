//
//  PurchaseView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var userPurchase : UserPurchase
    @State var showAddedAlert = false
    
    let tariffs = [
        Tariff(name: "Vacation (7 days)", days: 7, price: 99),
        Tariff(name: "Standart (1 month)", days: 30, price: 179),
        Tariff(name: "Profi (1 year)", days: 365, price: 699)
        
    ]
    
    var body: some View {
        ScrollView {
            
            VStack {
                Text("Privacy Matters")
                    .font(.title)
                Text("Protect your online activities with VPN Plus")
                    .padding()
                ForEach(tariffs, id: \.name) { tariff in
                    BuyView(tariff: tariff) {
                        userPurchase.tariff = tariff
                        showAddedAlert.toggle()
                    }.padding(.vertical, 30)
                }
            }
        }.scrollIndicators(.hidden)
            .alert(isPresented: $showAddedAlert, content: {
                Alert(title: Text("Tariff added to Cart"), message: Text("You added \(userPurchase.tariff.name)"), dismissButton: .default(Text("Ok")))
            })
    }
}
