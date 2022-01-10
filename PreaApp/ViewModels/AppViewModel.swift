//
//  AppViewModel.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import OpenAPIClient
import Combine

class AppViewModel: ObservableObject {
    
    // This is singleton why it is singletion come up with a reason
    public static var shared: AppViewModel = {
            let viewModel = AppViewModel()
            return viewModel
    }()
    
    
    @Published var authenticationViewModel = AuthenticationViewModel()
    
    @Published var token: Token?
    
    init() {
        OpenAPIClientAPI.basePath = "http://127.0.0.1:8000/api"
        let headers = ["Accept": "application/json",
                       "Content-Type": "application/json"
        ]
        OpenAPIClientAPI.customHeaders = headers
    }
    
}
