//
//  PreaAppApp.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import SwiftUI

@main
struct PreaAppApp: App {
    
    @StateObject var viewModel = AppViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            if viewModel.token != nil {
                ContentView()
            }
            else {
                AuthenticationView(viewModel: viewModel.authenticationViewModel)
            }
        }
    }
}
