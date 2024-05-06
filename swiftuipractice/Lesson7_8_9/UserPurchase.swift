//
//  UserPurchase.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 06.05.2024.
//

import SwiftUI

class UserPurchase: ObservableObject {
    @Published var tariff = Tariff(name: "", days: 0, price: 0)
}
