//
//  LoginViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/12/24.
//

import SwiftUI

class LoginViewModel : ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isPasswordHidden: Bool = true
    @Published var isLoggedIn: Bool = false
    
    public func onCheckCredential() { //TODO: Firebase Authentication Login
        let validCredentials = true
        if validCredentials {
            isLoggedIn = true
        } else {
            print("Invalid credentials")
        }
    }
}
