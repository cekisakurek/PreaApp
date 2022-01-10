//
//  RegisterViewModel.swift
//  PreaApp
//
//  Created by Cihan Emre Kisakurek on 10.01.22.
//

import Foundation
import Combine
import OpenAPIClient

class RegisterViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    // Bindings for registering a user
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    
    // Bindings for errors
    @Published var nameError: Bool = false
    @Published var emailError: Bool = false
    @Published var passwordError: Bool = false
    @Published var errorDescriptions: [String] = []
    
    func cancelLogin() {
        cancellable?.cancel()
    }
    
    func register() {
        
        let user = User(name: name, email: email, password: password)
        
        cancellable = UserAPI.register(user: user)
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
                
                if let nameErrors = validationError?.errors?.name {
                    self.nameError = true
                    self.errorDescriptions.append(contentsOf: nameErrors)
                }
                if let emailErrors = validationError?.errors?.email {
                    self.emailError = true
                    self.errorDescriptions.append(contentsOf: emailErrors)
                }
                if let passwordErrors = validationError?.errors?.password {
                    self.passwordError = true
                    self.errorDescriptions.append(contentsOf: passwordErrors)
                }
            }
        }
    }
}

