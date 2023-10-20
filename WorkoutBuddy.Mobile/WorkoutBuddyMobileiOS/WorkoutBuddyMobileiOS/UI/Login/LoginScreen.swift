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
    
    var body: some View {
        ZStack {
            CustomColors.background.ignoresSafeArea(.all)
            
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
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .foregroundColor(.white)
                            
                            TextField("", text: $viewModel.email)
                                .textFieldStyle(.plain)
                            
                            Spacer()
                        }
                    }.padding(.bottom, 28)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Password")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 14)
                                .foregroundColor(Color.white)
                            
                            SecureTextFieldWithReveal(text: $viewModel.password, color: .white)
                        }
                    }.padding(.bottom, 28)
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Sign in")
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(CustomColors.button)
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
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                            .padding(.vertical, 8)
                    }
                }.padding(.all, 36)
                .border(CustomColors.button, width: 4)
                    .cornerRadius(8)
                    
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
                .textContentType(.password)
                .focused($focus1)
                .opacity(showPassword ? 1 : 0)
            SecureField("", text: $text)
                .textContentType(.password)
                .focused($focus2)
                .opacity(showPassword ? 0 : 1)
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
