//
//  BuyView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct BuyView: View {
    var tariff: Tariff
    var action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Image("calendar")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text(String(tariff.days))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.black)
            }
            
            Text("\(tariff.name) \(tariff.price) RUB")
                .padding(.bottom)
            
            Button(action: {
                action()
            }) {
                Text("Add to Cart")
                    .frame(width: 150, height: 50)
            }
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
        }
    }
}

#Preview {
    BuyView(tariff: Tariff(name: "Vacation", days: 7, price: 99), action: {})
}
