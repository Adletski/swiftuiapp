//
//  AuthorizationView.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 07.05.2024.
//

import SwiftUI
import Combine

struct AuthorizationView: View {
    @State var loginText = ""
    @State var passwordText = ""
    @State var phoneNumber = ""
    @State var isEyeClosed = false
    @FocusState var loginIsFocused: Bool
    @FocusState var passwordIsFocused: Bool
    @State var isMoveToCheckVerification: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientHorizontal()
                Rectangle()
                    .fill(Color.white)
                    .edgesIgnoringSafeArea(.bottom)
                    .padding(.top, 50)
                VStack {
                    HStack {
                        Text("Log in")
                            .frame(width: 150, height: 55)
                            .font(.title2)
                        Text("Sign up")
                            .frame(width: 150, height: 55)
                            .background(.gray)
                            .cornerRadius(27)
                            .font(.title2)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 27).stroke(.gray)
                    )
                    
                    HStack {
                        Text("Phone number")
                        Spacer()
                    }.padding(.top, 30)
                    TextField("Input your phone number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.phoneNumber = filtered
                            }
                            formatPhoneNumber()
                        }
                        .textFieldStyle(.roundedBorder)
                        .focused($loginIsFocused)
                    HStack {
                        Text("Password")
                        Spacer()
                    }.padding(.top, 30)
                    HStack {
                        if isEyeClosed {
                            TextField("Input password", text: $passwordText).textFieldStyle(.roundedBorder)
                                .focused($passwordIsFocused)
                        } else {
                            SecureField("Input password", text: $passwordText).textFieldStyle(.roundedBorder)
                                .focused($passwordIsFocused)
                        }
                        Button(action: {
                            isEyeClosed.toggle()
                        }, label: {
                            if isEyeClosed {
                                Image("openEye")
                            } else {
                                Image("closeEye")
                            }
                        })
                    }
                    
                    NavigationLink(destination: CheckVerification(), isActive: $isMoveToCheckVerification) {
                        EmptyView()
                    }
                    
                    VStack(spacing: 20) {
                        Button("Sign up") {
                            loginIsFocused = false
                            passwordIsFocused = false
                        }
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 300, height: 50)
                        .background(
                            BackgroundGradientHorizontal()
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        Button("Forgot your password?") {
                            
                        }.foregroundColor(.gray).font(.system(size: 20, weight: .bold))
                        
                        Button("Check Verification") {
                            isMoveToCheckVerification = true
                        }.foregroundColor(.gray).font(.system(size: 20, weight: .bold))
                    }.padding(.top, 100)
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 100)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarBackButtonHidden()
        }
    }
        
        private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        private func formatPhoneNumber() {
            let numbers = phoneNumber.filter { "0123456789".contains($0) }
            let mask = "+X (XXX) XXX-XXXX"
            
            var result = ""
            var index = numbers.startIndex
            
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            
            if result != phoneNumber {
                phoneNumber = result
            }
        }
}

struct BackgroundGradientHorizontal: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 175/255, green: 224/255, blue: 197/255),
                Color(red: 50/255, green: 75/255, blue: 53/255)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    AuthorizationView()
}
