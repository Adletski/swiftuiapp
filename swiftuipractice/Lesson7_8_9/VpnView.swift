//
//  VpnView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

struct VpnView: View {
    @State private var vpnOn = false
    
    var body: some View {
        VStack {
            Spacer()
          CountrySelectView()
            
            Toggle("", isOn: $vpnOn)
                .frame(width: 50, height: 50)
                .padding(.vertical, 30)
            HStack {
                Text("IP Address")
                Spacer()
                Text("127.0.0.1")
                    .bold()
            }
            .padding(.horizontal, 100)
            .padding(8)
            HStack {
                Text("Received")
                Spacer()
                Text("0 MB")
                    .bold()
            }
            .padding(.horizontal, 100)
            .padding(8)
            HStack {
                Text("Sent")
                Spacer()
                Text("0 MB")
                    .bold()
            }
            .padding(.horizontal, 100)
            .padding(8)
            Spacer()
            ZStack {
                Color.gray.opacity(0.15)
                Text("Service will expire after 15 days")
            }
            .frame(height: 80)
        }
    }
}
