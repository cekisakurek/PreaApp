//
//  LoginViewModel.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import Foundation
import OpenAPIClient
import Combine

class LoginViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailError: Bool = false
    @Published var passwordError: Bool = false
    @Published var errorDescriptions: [String] = []
    
    func cancelLogin() {
        cancellable?.cancel()
    }
    
    func login() {
               
        let user = User(email: email, password: password)
        
        cancellable = UserAPI.authenticate(user: user)
            .sink {
                [weak self]
                completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.handleErrorResponse(error: error as? ErrorResponse)
                }
        } receiveValue: { token in AppViewModel.shared.token = token }
    }
    
    private func handleErrorResponse(error: ErrorResponse?) {
        
        guard let error = error else { return }
        
        switch error {
            case let .error(statusCode, data, _, _):
            // http 422 means we send wrong/missing data
            if statusCode == 422 {
                let validationError = try? JSONDecoder().decode(ModelError.self, from: data!)
                
                if let emailErrors = validationError?.errors?.email {
                    self.emailError = true
                    self.errorDescriptions.append(contentsOf: emailErrors)
                }
                if let passwordErrors = validationError?.errors?.password {
                    self.passwordError = true
                    self.errorDescriptions.append(contentsOf: passwordErrors)
                }
            }
            else if statusCode == 401{
                let validationError = try? JSONDecoder().decode(ModelError.self, from: data!)
                self.passwordError = true
                self.emailError = true
                self.errorDescriptions.append(validationError!.message!)
            }
        }
    }
}
