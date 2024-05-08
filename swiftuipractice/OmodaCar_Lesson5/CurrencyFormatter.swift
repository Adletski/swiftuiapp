//
//  CurrencyFormatter.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 04.05.2024.
//

import Foundation

final class CurrencyFormatter {
    static func formatCurrency(amount: Double) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "Р"
            formatter.maximumFractionDigits = 0
            formatter.minimumFractionDigits = 0
            formatter.locale = Locale(identifier: "ru_RU")

            if let formatteredAmount = formatter.string(from: NSNumber(value: amount)) {
                return formatteredAmount
            } else {
                return "0 ₽"
            }
        }
}
