//
//  RegisterViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/12/24.
//

import SwiftUI

class RegisterViewModel : ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isPasswordHidden: Bool = true
    @Published var isRegistered: Bool = false
    
    public func onRegisterCredential() { //TODO: Firebase Authentication Registration
        let validCredentials = true
        if validCredentials {
            isRegistered = true
        } else {
            print("Invalid credentials")
        }
    }
}
