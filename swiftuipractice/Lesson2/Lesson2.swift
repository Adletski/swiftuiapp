//
//  SecondTask.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 29.04.2024.
//

import SwiftUI

class Card: ObservableObject {
    @Published var name: String
    @Published var balance: Double
    @Published var accountNumber: Int
    
    init(name: String, balance: Double, accountNumber: Int) {
        self.name = name
        self.balance = balance
        self.accountNumber = accountNumber
    }
}

struct SecondTask: View {
    @ObservedObject var card1: Card
    @ObservedObject var card2: Card
    @ObservedObject var card3: Card
    @State var stateCard: Card
    @State var isBalancePopUp = false
    @State var isTransferDidTap = false
    @State var isWalletToggle = false
    @State var userInput: String = ""
    @State var amountTextField: String = ""
    @State var accountTextField: String = ""
    
    init(card1: Card, card2: Card, card3: Card) {
        self.card1 = card1
        self.card2 = card2
        self.card3 = card3
        self.stateCard = card1
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Image("card")
                                VStack(alignment: .leading) {
                                    Text(String(card1.balance) + " P").font(.system(size: 12))
                                    Text("MIR  **000\(card1.accountNumber)").font(.system(size: 12))
                                }.onTapGesture {
                                    stateCard = card1
                                    isWalletToggle = false
                                }
                            }
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 100, height: 1)
                            HStack {
                                Image("card")
                                VStack(alignment: .leading) {
                                    Text(String(card2.balance) + " P").font(.system(size: 12))
                                    Text("MIR  **000\(card2.accountNumber)").font(.system(size: 12))
                                }.onTapGesture {
                                    stateCard = card2
                                    isWalletToggle = false
                                }
                            }
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 100, height: 1)
                            HStack {
                                Image("card")
                                VStack(alignment: .leading) {
                                    Text(String(card3.balance) + " P").font(.system(size: 12))
                                    Text("MIR  **000\(card3.accountNumber)").font(.system(size: 12))
                                }.onTapGesture {
                                    stateCard = card3
                                    isWalletToggle = false
                                }
                            }
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 100, height: 1)
                        }
                        Spacer()
                    }.offset(x: 25)
                    Spacer()
                }
                Rectangle()
                    .fill(Color("background"))
                    .offset(x: isWalletToggle ? 140 : 0)
                VStack(alignment: .leading, spacing: 40) {
                    Text(stateCard.name)
                        .offset(x: isWalletToggle ? 140 : 0)
                        .font(.system(size: 20, weight: .bold))
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("cardBackground"))
                            .frame(width: 360, height: 200)
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(String(stateCard.balance) + " P")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                    Text("доступно").foregroundColor(Color("secondaryText"))
                                    Spacer()
                                }
                                Spacer()
                                VStack {
                                    Spacer()
                                    Image("logo_mir")
                                }
                            }
                        }
                        .frame(width: 320, height: 170)
                    }.offset(x: isWalletToggle ? 140 : 0)
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.white)
                            .frame(height: 88)
                            .shadow(radius: 1, y: 4)
                        HStack(spacing: 40) {
                            VStack(spacing: 20) {
                                Image("popup")
                                Text("Пополнить").font(.system(size: 14))
                            }.onTapGesture {
                                isBalancePopUp = true
                                stateCard.balance += 1000
                            }.actionSheet(isPresented: $isBalancePopUp, content: {
                                ActionSheet(title: Text("Success"))
                            })
                            VStack(spacing: 20) {
                                Image("transfer")
                                Text("Перевести").font(.system(size: 14))
                            }.onTapGesture {
                                isTransferDidTap = true
                            }.alert("Перевод", isPresented: $isTransferDidTap) {
                                TextField("Введите сумму перевода", text: $amountTextField).keyboardType(.numberPad)
                                Button("Карта 1") {
                                    stateCard.balance -= Double(amountTextField) ?? 0
                                    card1.balance += Double(amountTextField) ?? 0
                                    amountTextField = ""
                                }
                                Button("Карта 2") {
                                    stateCard.balance -= Double(amountTextField) ?? 0
                                    card2.balance += Double(amountTextField) ?? 0
                                    amountTextField = ""
                                }
                                Button("Карта 3") {
                                    stateCard.balance -= Double(amountTextField) ?? 0
                                    card3.balance += Double(amountTextField) ?? 0
                                    amountTextField = ""
                                }
                                Button("Cancel"){}
                            }
                            VStack(spacing: 20) {
                                Image("opencard")
                                VStack {
                                    Text("Открыть карту").font(.system(size: 14)).lineLimit(2)
                                }
                            }
                        }
                    }.offset(x: isWalletToggle ? 140 : 0)
                    Spacer()
                }
                .padding(30)
            }
            Toggle(isOn: $isWalletToggle) {
                Text("Показать мой кошелек")
            }.padding()
        }.animation(.spring(response: 0.5,
                            dampingFraction: 0.7,
                            blendDuration: 0.3))
    }
}

#Preview {
    SecondTask(
        card1: Card(name: "Карта1", balance: 50000.00, accountNumber: 1),
        card2: Card(name: "Карта2", balance: 100000.00, accountNumber: 2),
        card3: Card(name: "Карта3", balance: 1000.00, accountNumber: 3)
    )
}

struct CustomAlert: View {
    @Binding var showModal: Bool
    @State private var userInput: String = ""

    var body: some View {
        VStack {
            Text("Введите данные")
                .font(.headline)

            TextField("Введите здесь", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Готово") {
                showModal = false  // Закрыть модальное окно
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())

            Button("Отмена") {
                showModal = false  // Закрыть модальное окно без сохранения данных
            }
            .padding()
        }
        .padding()
    }
}
