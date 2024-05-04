//
//  OrderScreenViewModel.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 04.05.2024.
//

import Foundation

/// ViewModel для экрана оформления заказа машины
final class OrderScreenViewModel: ObservableObject {
    
    @Published var orderSheetIsOn = false
    @Published var kaskoAlertIsOn = false
    @Published var kaskoToggleIsOn = false
    @Published var isShareActivityPresented = false
    var selection = 0 {
        didSet {
            print(selection)
            objectWillChange.send()
        }
    }
    
    var cars: [CarInfo] = [
        CarInfo(carName: "C5", carImageName: "c5", engine: "1.6 Turbo", carWheelDrive: "AWD", basePrice: 2189900),
        CarInfo(carName: "S5", carImageName: "s5", engine: "1.8 Turbo", carWheelDrive: "AWD", basePrice: 1889900),
        CarInfo(carName: "S5 GT", carImageName: "s5gt", engine: "2.0 Turbo", carWheelDrive: "AWD", basePrice: 2189900)
    ]
    
    func toggleKasko() {
        print("kasko on")
        kaskoAlertIsOn.toggle()
    }
    
    func orderButtonTapped() {
        print("order on")
        orderSheetIsOn.toggle()
    }
    
    func share() {
        isShareActivityPresented.toggle()
    }
}
