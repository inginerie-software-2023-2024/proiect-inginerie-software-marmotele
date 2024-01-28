//
//  LoginScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel = LoginViewModel()
    
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Sign in to your account")
                    .bold()
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.bottom, 28)
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Email address")
                            .font(.system(size: 14))
                            .foregroundColor(CustomColors.button)
                            .padding(.bottom, 8)
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .foregroundColor(.white)
                            
                            TextField("", text: $viewModel.email)
                                .foregroundColor(CustomColors.button)
                                .font(.system(size: 12))
                                .placeholder(when: viewModel.email.isEmpty) {
                                    Text("Enter your email")
                                        .foregroundColor(CustomColors.buttonDark)
                                        .font(.system(size: 12))
                                }
                            
                            Spacer()
                        }.padding(.all, 12)
                            .focused($isEmailFocused)
                            .border(isEmailFocused ? CustomColors.button : .white, width: 2)
                            .cornerRadius(4)
                    }.padding(.bottom, 28)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Password")
                            .font(.system(size: 14))
                            .foregroundColor(CustomColors.button)
                            .padding(.bottom, 8)
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .foregroundColor(.white)
                            
                            SecureTextFieldWithReveal(text: $viewModel.password)
                        }.padding(.all, 12)
                            .focused($isPasswordFocused)
                            .border(isPasswordFocused ? CustomColors.button : .white , width: 2)
                            .cornerRadius(4)
                    }.padding(.bottom, 28)
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Sign in")
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(CustomColors.button)
                            .cornerRadius(4)
                            .foregroundColor(CustomColors.backgroundDark)
                        
                    }
                }.padding(.all, 36)
                    .border(CustomColors.buttonDark, width: 2)
                    .cornerRadius(4)
                    
            }
            .padding(.horizontal, 20)
        }.onReceive(viewModel.loginCompletion) { loginCompletion in
            switch loginCompletion {
            case .failure(_):
                let modal = ModalChooseOptionView(title: "Oops",
                                                  description: "An error has occured. Please try again later!",
                                                  topButtonText: "Retry") {
                    navigation.dismissModal(animated: true, completion: nil)
                }
                navigation.presentModal(modal.asDestination(),
                                        animated: true,
                                        completion: nil,
                                        controllerConfig: nil)
            case .login:
                navigation.replaceNavigationStack([HomeScreen().asDestination()], animated: true)
            }
        }
    }
}

struct SecureTextFieldWithReveal: View {
    @FocusState private var focus1: Bool
    @FocusState private var focus2: Bool
    @State private var showPassword: Bool = false
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("", text: $text)
                .foregroundColor(CustomColors.button)
                .font(.system(size: 12))
                .textContentType(.password)
                .focused($focus1)
                .opacity(showPassword ? 1 : 0)
                .placeholder(when: text.isEmpty) {
                    Text("Enter your password")
                        .foregroundColor(CustomColors.buttonDark)
                        .font(.system(size: 12))
                }
            SecureField("", text: $text)
                .textContentType(.password)
                .focused($focus2)
                .opacity(showPassword ? 0 : 1)
                .foregroundColor(CustomColors.button)
            Button(action: {
                showPassword.toggle()
                if showPassword { focus1 = true } else { focus2 = true }
            }) {
                Image(systemName: self.showPassword ? "eye.slash" : "eye")
                    .frame(height: 12)
                    .foregroundColor(.white)
            }
        }
    }
}

