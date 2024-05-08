//
//  CheckVerification.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 08.05.2024.
//

import SwiftUI

struct CheckVerification: View {
    @State var randomNumber = 0
    
    var body: some View {
        ZStack {
            BackgroundGradientHorizontal()
            rectangleView()
            VStack {
                Text("Verification")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                checkSMSView(randomNumber: $randomNumber)
                Spacer()
            }
        }
    }
}

struct rectangleView: View {
    var body: some View {
        Rectangle()
            .fill(.white)
            .edgesIgnoringSafeArea(.bottom)
            .padding(.top, 60)
    }
}

struct checkSMSView: View {
    @State private var pin: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusedField: Int?
    @Binding var randomNumber: Int
    @State var showAlert = false
    
    var body: some View {
        Image("sms")
            .resizable()
            .frame(width: 200, height: 200)
        Text("Verification code")
            .font(.system(size: 20))
        HStack(spacing: 20) {
            ForEach(0..<4, id: \.self) { index in
                TextField("", text: $pin[index])
                    .frame(width: 45, height: 55)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .focused($focusedField, equals: index)
                    .onChange(of: pin[index]) { newValue in
                        if newValue.count == 1 && index < 3 {
                            focusedField = index + 1
                        } else if newValue.count == 0 && index > 0 {
                            focusedField = index - 1
                        }
                    }
                    .onSubmit {
                        if index == 3 {
                            print("pincode setted up")
                        }
                    }
            }
        }
        .padding()
        VStack(spacing: 20) {
            Text("Check the SMS").fontWeight(.bold).font(.title)
            Text("message to get verification code")
            Button {
                print("continue button pressed")
            } label: {
                Text("Continue")
            }
            .frame(width: 300, height: 55)
            .background(BackgroundGradientHorizontal())
            .cornerRadius(25)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.title2)
            
            Text("Didn't receive sms")
            Button("Send sms again") {
               showAlert = true
                randomNumber = Int.random(in: 1000...9999)
            }
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Fill in from message"),
                    message: Text("\(randomNumber)"),
                    primaryButton: .cancel(),
                    secondaryButton: .default(Text("OK"), action: {
                        for index in pin.indices {
                            pin[index] = String(Array(String(randomNumber))[index])
                        }
                    }))
            })
            .fontWeight(.bold)
            .foregroundColor(.black)
        }
    }
}

#Preview {
    CheckVerification()
}
