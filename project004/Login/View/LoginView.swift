//
//  LoginView.swift
//  project004
//
//  Created by user250318 on 9/20/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
      
      var body: some View {
        Form {
          // Username
          Section {
            TextField("Username", text: $viewModel.username)
              .autocapitalization(.none)
              .disableAutocorrection(true)
          } footer: {
            Text(viewModel.usernameMessage)
              .foregroundColor(.red)
          }
          
          // Password
          Section {
            SecureField("Password", text: $viewModel.password)
            SecureField("Repeat password", text: $viewModel.passwordConfirmation)
          } footer: {
            Text(viewModel.passwordMessage)
              .foregroundColor(.red)
          }
          
          // Submit button
          Section {
            Button("Login") {
              print("Signing up as \(viewModel.username)")
            }
            .disabled(!viewModel.isValid)
          }
        }
      }
}

#Preview {
    LoginView()
}
