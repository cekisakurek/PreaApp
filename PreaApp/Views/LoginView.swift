//
//  LoginView.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        Form {
            TextField("Enter email...", text: $viewModel.email)
                .background(viewModel.emailError ? Color.red : Color.white)
            TextField("Enter password...", text: $viewModel.password)
                .background(viewModel.passwordError ? Color.red : Color.white)
            Button("Login") {
                viewModel.login()
            }
            if (viewModel.errorDescriptions.count != 0) {
                ForEach(viewModel.errorDescriptions, id: \.self) { error in
                    Text(error)
                }
            }
        }
        .navigationTitle("Login")
    }
}
