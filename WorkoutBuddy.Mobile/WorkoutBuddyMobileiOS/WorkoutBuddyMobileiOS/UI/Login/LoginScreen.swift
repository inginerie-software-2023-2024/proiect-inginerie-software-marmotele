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
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                Text("Sign in to your account")
                    .bold()
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.bottom, 28)
                
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Email address")
                            .font(.system(size: 14))
                            .foregroundColor(CustomColors.myNude)
                            .padding(.bottom, 16)
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .foregroundColor(CustomColors.myNude)
                            
                            TextField("", text: $viewModel.email)
                                .foregroundColor(CustomColors.myNude)
                                .font(.system(size: 12))
                                .placeholder(when: viewModel.email.isEmpty) {
                                    Text("Enter your email")
                                        .foregroundColor(CustomColors.myNude)
                                        .font(.system(size: 12))
                                }
                            
                            Spacer()
                        }.padding(.all, 12)
                            .focused($isEmailFocused)
                            .border(isEmailFocused ? CustomColors.myNude : .white, width: 2)
                            .cornerRadius(4)
                    }.padding(.bottom, 28)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Password")
                            .font(.system(size: 14))
                            .foregroundColor(CustomColors.myNude)
                            .padding(.bottom, 8)
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .foregroundColor(CustomColors.myNude)
                            
                            SecureTextFieldWithReveal(text: $viewModel.password,
                                                      color: CustomColors.myNude)
                        }.padding(.all, 12)
                            .focused($isPasswordFocused)
                            .border(isPasswordFocused ? CustomColors.myNude : .white , width: 2)
                            .cornerRadius(4)
                    }.padding(.bottom, 28)
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Sign in")
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(CustomColors.myNude)
                            .cornerRadius(4)
                            .foregroundColor(CustomColors.background)
                        
                    }.onReceive(viewModel.loginCompletion) { loginCompletion in
                        switch loginCompletion {
                        case .failure(let error):
                            viewModel.errorMessage = error.localizedDescription
                            print("Login failed: \(error)")
                        case .login:
                            navigation.replaceNavigationStack([HomeScreen().asDestination()], animated: true)
                        }
                    }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text("\(viewModel.errorMessage)")
                            .foregroundColor(CustomColors.myError)
                            .font(.system(size: 12))
                            .padding(.vertical, 8)
                    }
                }.padding(.all, 36)
                    .border(.white, width: 2)
                    .cornerRadius(4)
                    
            }
            .padding(.horizontal, 20)
        }
    }
}

struct SecureTextFieldWithReveal: View {
    @FocusState private var focus1: Bool
    @FocusState private var focus2: Bool
    @State private var showPassword: Bool = false
    @Binding var text: String
    @State var color: Color
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("", text: $text)
                .foregroundColor(CustomColors.myNude)
                .font(.system(size: 12))
                .textContentType(.password)
                .focused($focus1)
                .opacity(showPassword ? 1 : 0)
                .placeholder(when: text.isEmpty) {
                    Text("Enter your password")
                        .foregroundColor(CustomColors.myNude)
                        .font(.system(size: 12))
                }
            SecureField("", text: $text)
                .textContentType(.password)
                .focused($focus2)
                .opacity(showPassword ? 0 : 1)
                .foregroundColor(CustomColors.myNude)
            Button(action: {
                showPassword.toggle()
                if showPassword { focus1 = true } else { focus2 = true }
            }) {
                Image(systemName: self.showPassword ? "eye.slash" : "eye")
                    .frame(height: 12)
                    .foregroundColor(color)
            }
        }
    }
}

