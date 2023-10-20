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
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundColor(Color.black)
                    
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.plain)
                    
                Spacer()
            }.padding(.bottom, 10)
            
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, 2)
                .foregroundColor(Color.black)
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundColor(Color.black)
                    .padding(.leading, 2)
                
                SecureTextFieldWithReveal(text: $viewModel.password, color: Color.black)
            }.padding(.vertical, 10)
            
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, 2)
                .foregroundColor(Color.black)
            
            Button {
                viewModel.login()
            } label: {
                Text("Log in")
                    .frame(height: 40)
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.black, .black],
                                                  startPoint: .top,
                                                  endPoint: .bottomTrailing))
                    )
                    .foregroundColor(.white)
                
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
                    .padding(.top, 4)
            }
        }.padding(.horizontal, 12)
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
            TextField("Password", text: $text)
                .textContentType(.password)
                .focused($focus1)
                .opacity(showPassword ? 1 : 0)
            SecureField("Password", text: $text)
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
                    .padding(.trailing, 12)
            }
        }
    }
}
