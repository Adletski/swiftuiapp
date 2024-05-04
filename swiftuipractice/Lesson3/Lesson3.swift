//
//  Lesson3.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 30.04.2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct Lesson3: View {
    enum Constant {
        static let settingsText = "Настройки"
        static let nameText = "Adlet"
        static let appleIdText = "Apple ID, iCloud, контент и покупки"
        static let appleIDSuggestions = "Предложения Apple ID"
        static let threeText = "3"
        static let ios17_2Text = "IOS 17.2: уже доступно"
        static let airplaneModeText = "Авиарежим"
        static let wiFiText = "Wi-Fi"
        static let bluetoothText = "Bluetooth"
        static let cellularCommunicationText = "Сотовая связь"
        static let modemModeText = "Режим модема"
        static let vPNText = "VPN"
    }
    
    @State private var isOnAirplaneMode = false
    @State private var isOnVPN = false
    @State private var selectionFirstWifi = 0
    @State private var selectionFirstBluetooth = 0
    @State private var selectionThirdModemMode = 0
    @State private var sectionWiFi = ["Подключено", "Не подключено"]
    @State private var selectionOnOff = ["Вкл.", "Выкл."]
    
    var body: some View {
        NavigationView {
            Form {
                firstSectionView
                secondSection
//                thirdSectionView
                Section {
                    Toggle(isOn: $isOnAirplaneMode) {
                        HStack {
                            setupIcon(color: .orange, image: .plane)
                            Text(Constant.airplaneModeText)
                                .font(.system(size: 18, weight: .regular))
                        }
                    }
                    Picker(selection: $selectionFirstWifi, content: {
                        ForEach(sectionWiFi.indices, id: \.self) { 
                            Text(sectionWiFi[$0])
                        }
                    }, label: {
                        setupIcon(color: .blue, image: .wifi)
                        Text(Constant.wiFiText)
                    }).pickerStyle(.navigationLink)
                    
                    
    
                    Picker(selection: $selectionFirstBluetooth, content: {
                        ForEach(selectionOnOff.indices, id: \.self) {  
                            Text(selectionOnOff[$0])
                        }
                    }, label: {
                        setupIcon(color: .blue, image: .bluetooth)
                        Text(Constant.bluetoothText)
                    }).pickerStyle(.navigationLink)
                    NavigationLink {} label: {
                        setupIcon(color: .green, image: .cellularCommunication)
                        Text(Constant.cellularCommunicationText)
                    }
                    Picker(selection: $selectionFirstBluetooth, content: {
                        ForEach(selectionOnOff.indices, id: \.self) {  Text(selectionOnOff[$0])
                        }
                    }, label: {
                        setupIcon(color: .green, image: .modemMode)
                        Text(Constant.modemModeText)
                    }).pickerStyle(.navigationLink)
        
                    Toggle(isOn: $isOnVPN) {
                        HStack {
                            setupIcon(color: .green, image: .vpn)
                            Text(Constant.vPNText)
                        }
                    }
                }
            }.navigationTitle(Text(Constant.settingsText))
        }
    }
    
    private var firstSectionView: some View {
        Section {
            HStack() {
                Image(.cat)
                NavigationLink {} label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(Constant.nameText)
                            .font(.system(size: 22, weight: .bold))
                        Text(Constant.appleIdText)
                            .font(.system(size: 12, weight: .regular))
                    }
                }
            }
            
            NavigationLink {} label: {
                HStack {
                    Text(Constant.appleIDSuggestions)
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 25, height: 25)
                        Text(Constant.threeText)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private var secondSection: some View {
        Section {
            NavigationLink {} label: {
                HStack {
                    Text(Constant.ios17_2Text)
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 25, height: 25)
                        Text(Constant.threeText)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private func setupIcon(color: Color, image: ImageResource) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 30, height: 30)
            Image(image)
        }.padding(4)
    }
}

//@available(iOS 16.0, *)
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView3()
//    }
//}
@available(iOS 16.0, *)
#Preview {
    Lesson3()
}
