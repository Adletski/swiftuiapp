//
//  OrderView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 04.05.2024.
//

import SwiftUI

/// Элемент выбора авто, комплектации и оформления заказа
struct OrderView: View {
    
    private enum Constants {
        static let equipments = ["Joy", "Lifestyle", "Ultimate", "Active", "Supreme"]
        static let infoTitleText = "Информация об автомобиле"
        static let engineText = "Двигатель"
        static let wheelDriveText = "Привод"
        static let equipmentText = "Комплектация"
        static let omodaKastoText = "ОМОДА Каско"
        static let priceText = "Цена"
        static let orderButtonTitleText = "Заказать"
        static let kaskoOfferText = "Подключить на выгодных условиях?"
        static let yesButtonText = "Да"
        static let noButtonText = "Нет"
        static let actionViewTitleText = "Благодарим за заказ"
        static let actionSheetMessageText = "Наш менеджер свяжется с Вами в рабочее время для уточнения деталей."
    }
    
    @ObservedObject var viewModel: OrderScreenViewModel
    @Binding var car: CarInfo

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 440)
                .foregroundColor(.white)
                .padding(.bottom, -(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
            
            VStack {
                Text(Constants.infoTitleText)
                    .font(.custom("Verdana-Bold", size: 18))
                    .padding(.horizontal)
                
                HStack {
                    Text(Constants.engineText)
                    Spacer()
                    Text(car.engine)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                    .padding(.horizontal, 70)
                
                HStack {
                    Text(Constants.wheelDriveText)
                    Spacer()
                    Text(car.carWheelDrive)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                    .padding(.horizontal, 70)
                
                HStack {
                    Text(Constants.equipmentText)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                VStack {
                    
                    Slider(value: Binding(get: {
                        selectedValue
                    }, set: { newValue in
                        let newValue = (newValue * 4).rounded() / 4
                        selectedValue = Double(newValue)
                        additionalPrice = Int(760000 * newValue)
                    }), in: 0...1)
                        .accentColor(.black)
                        .padding(.horizontal,50)
                        .onAppear {
                                        let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
                                        UISlider.appearance()
                                            .setThumbImage(UIImage(systemName: "circle.fill",
                                                                   withConfiguration: progressCircleConfig), for: .normal)
                                    }
                    
                    HStack {
                        ForEach(Constants.equipments.indices, id: \.self) { index in
                            Text(Constants.equipments[index])
                                .font(.custom("Verdana", size: 12))
                                .frame(width: 60)
                        }
                    }
                }
                
                Toggle(isOn: $viewModel.kaskoToggleIsOn) {
                    Text(Constants.omodaKastoText)
                        .font(.custom("Verdana", size: 16))
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .onChange(of: viewModel.kaskoToggleIsOn) { oldValue, newValue in
                    if newValue == true {
                        viewModel.kaskoAlertIsOn = true
                    }
                    if newValue == false {
                        kaskoPrice = 0
                    }
                }
                
                Divider()
                    .padding(.horizontal, 70)
                
                HStack {
                    Text(Constants.priceText)
                        .font(.custom("Verdana-Bold", size: 18))
                    Spacer()
                    
                    Text(CurrencyFormatter.formatCurrency(amount: Double(car.basePrice + additionalPrice + kaskoPrice)))
                        .font(.custom("Verdana-Bold", size: 18))
                }
                .padding(.horizontal)
                
                Button {
                    viewModel.orderButtonTapped()
                } label: {
                    Text(Constants.orderButtonTitleText)
                        .font(.custom("Verdana-Bold", size: 18))
                        .foregroundColor(.white)
                }
                .frame(width: 350, height: 48)
                .background(.lesson6Bg)
                .cornerRadius(8)
                

            }
        }
        .alert(isPresented: $viewModel.kaskoAlertIsOn) {
            Alert(title: Text(Constants.omodaKastoText), message: Text(Constants.kaskoOfferText),
                  primaryButton: .cancel(Text(Constants.yesButtonText).font(.system(size: 12,weight: .bold)),
                                          action: {
                kaskoPrice = 99000
                viewModel.kaskoToggleIsOn = true
            }), secondaryButton: .default(
                Text(Constants.noButtonText)
                    .font(.custom("Verdana", size: 6))
                    .fontWeight(.regular),
                action: {
                    viewModel.kaskoToggleIsOn = false
            }))
        }
        .actionSheet(isPresented: $viewModel.orderSheetIsOn, content: {
            ActionSheet(title: Text(Constants.actionViewTitleText), message: Text(Constants.actionSheetMessageText))
        })
    }
    
    @State private var selectedValue = 0.0
    @State private var orderSheetIsOn = false
    @State private var finalPrice = 0
    @State private var additionalPrice = 0
    @State private var kaskoPrice = 0
    
}

#Preview(body: {
    OrderView(viewModel: OrderScreenViewModel(), car: .constant(CarInfo(carName: "C5", carImageName: "c5", engine: "1.6 Turbo", carWheelDrive: "AWD", basePrice: 2189000)) )
})


