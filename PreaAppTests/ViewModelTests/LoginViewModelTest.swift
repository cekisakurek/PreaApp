//
//  LoginViewModelTest.swift
//  PreaAppTests
//
//  Created by Cihan Emre Kisakurek on 11.01.22.
//

import Foundation
import XCTest
import OpenAPIClient
@testable import PreaApp

class LoginViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        
        let loginViewModel = LoginViewModel()
        loginViewModel.email = "cekisakurek@gmail.com"
        loginViewModel.password = "password"
        let (_, error) = try awaitPublisher(loginViewModel.loginPublisher())
        
        loginViewModel.handleErrorResponse(error: error as? ErrorResponse)
        
        // if we try to login with invalid credentials we have both email and password error
        XCTAssertTrue(loginViewModel.emailError)
        XCTAssertTrue(loginViewModel.passwordError)
        
        for message in loginViewModel.errorDescriptions {
            XCTAssert(message == "Credentials not match")
        }
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
