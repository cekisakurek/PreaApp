//
//  WelcomeViewModel.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import Foundation

class AuthenticationViewModel: ObservableObject {

    private var _loginViewModel: LoginViewModel?
    private var _registerViewModel: RegisterViewModel?
    
    func loginViewModel() -> LoginViewModel {
        
        if _loginViewModel != nil { return _loginViewModel! }
        
        _loginViewModel = LoginViewModel()
        return _loginViewModel!
    }
    
    func registerViewModel() -> RegisterViewModel {
        
        if _registerViewModel != nil { return _registerViewModel! }
        
        _registerViewModel = RegisterViewModel()
        return _registerViewModel!
    }
}
