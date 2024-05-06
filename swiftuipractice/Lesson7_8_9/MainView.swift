//
//  MainView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var userPurchase = UserPurchase()
    
    var body: some View {
        TabView {
            VpnView()
                .tabItem {
                    Label("VPN", systemImage: "lock")
                }
            PurchaseView()
                .environmentObject(userPurchase)
                .tabItem {
                    Label("Purchase", systemImage: "list.bullet")
                }
            CartView()
                .environmentObject(userPurchase)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
    }
}
