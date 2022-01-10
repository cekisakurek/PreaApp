//
//  RegisterView.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 11.01.22.
//

import SwiftUI
struct RegisterView: View {
    
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        Form {
            TextField("Enter name...", text: $viewModel.name)
                .background(viewModel.nameError ? Color.red : Color.white)
            TextField("Enter email...", text: $viewModel.email)
                .background(viewModel.emailError ? Color.red : Color.white)
            TextField("Enter password...", text: $viewModel.password)
                .background(viewModel.passwordError ? Color.red : Color.white)
            TextField("Enter password again...", text: $viewModel.passwordCheck)
                .background(viewModel.passwordError ? Color.red : Color.white)
            Button("Register") {
                viewModel.register()
            }
            if (viewModel.errorDescriptions.count != 0) {
                ForEach(viewModel.errorDescriptions, id: \.self) { error in
                    Text(error)
                }
            }
        }
        .navigationTitle("Register")
        
    }
}
