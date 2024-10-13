//
//  LoginViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/12/24.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel : ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isPasswordHidden: Bool = true
    @Published public var isLoggedIn: Bool = false
    private let firebaseAuth = Auth.auth()

    public func onCheckCredential() {
        DispatchQueue.global().async {
            print("LoginViewModel onCheckCredential \(self.email) \(self.password)")
            self.firebaseAuth.signIn(withEmail: self.email, password: self.password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print("LoginViewModel Authentication error: \(error.localizedDescription)")
                } else {
                    strongSelf.isLoggedIn = true
                }
            }
        }
    }
}
