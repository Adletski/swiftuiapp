//
//  FurnitureStore.swift
//  swiftuipractice
//
//  Created by Adlet Zhantassov on 07.05.2024.
//

import SwiftUI

struct FurnitureStore: View {
    @State var isAuthorization = false
    @State var showFullScreenDetails = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradient()
                VStack {
                    Text("169.ru").modifier(Text169Modifier())
                    
                    asyncImageView.padding(.top, 40)
                    
                    Button(action: {
                        showFullScreenDetails = true
                    }, label: {
                        Text("Get started")
                            .font(.title2)
                            .fontWeight(.bold)
                    }).modifier(GetStartedModifier())
                        .fullScreenCover(isPresented: $showFullScreenDetails) {
                            DetailsView(showFullScreenModal: $showFullScreenDetails)
                        }
                    
                    Button("Don't have an account?") {
                        print("dont have accounr")
                    }.modifier(DontHaveAccountModifier())
                    
                    NavigationLink(destination: AuthorizationView(), isActive: $isAuthorization) {
                        EmptyView()
                    }
                    
                    Button("Sing in here") {
                        isAuthorization = true
                    }.modifier(SignInHereModifier())
                    Spacer()
                }
            }
        }
    }
    
    var asyncImageView: some View {
        AsyncImage(url: URL(string: "https://picsum.photos/401")) { phase in
            switch phase {
            case .empty:
                ProgressView().accentColor(.accentColor)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
            case .failure(let error):
                VStack {
                    Image(systemName: "questionmark")
                    Text(error.localizedDescription)
                        .font(.headline)
                }
            @unknown default:
                fatalError()
            }
        }
    }
}

struct Text169Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40))
            .fontWeight(.bold)
            .padding(.top, 60)
            .foregroundColor(.white)
    }
}

struct GetStartedModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 55)
            .background(.white)
            .cornerRadius(27)
            .padding(.top, 100)
    }
}

struct DontHaveAccountModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding(.top, 50)
    }
}

struct SignInHereModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.white)
    }
}

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 175/255, green: 224/255, blue: 197/255),
                Color(red: 50/255, green: 75/255, blue: 53/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    FurnitureStore()
}
