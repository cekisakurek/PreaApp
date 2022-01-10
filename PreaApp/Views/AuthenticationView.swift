//
//  WelcomeView.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import SwiftUI

struct AuthenticationView: View {
    
    @StateObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink(destination: LoginView(viewModel: viewModel.loginViewModel())) {
                    NavigationText(text: "Login")
                }
                NavigationLink(destination: RegisterView(viewModel: viewModel.registerViewModel())) {
                    NavigationText(text: "Register")
                }
            }
        }
    }
    
    private struct NavigationText: View {
        
        var text: String
        
        var body: some View {
            Text(text)
                .padding()
                .cornerRadius(15)
                .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
        }
    }
}
