//
//  RegisterViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/12/24.
//

import SwiftUI
import FirebaseAuth

class RegisterViewModel : ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isPasswordHidden: Bool = true
    @Published public var isRegistered: Bool = false
    private let firebaseAuth = Auth.auth()
    
    public func onRegisterCredential() { //TODO: Firebase Authentication Registration
        DispatchQueue.global().async {
            print("RegisterViewModel onRegisterCredential \(self.email) \(self.password)")
            Auth.auth().createUser(withEmail: self.email, password: self.password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print("RegisterViewModel Authentication error: \(error.localizedDescription)")
                } else {
                    strongSelf.isRegistered = true
                }
            }
        }
    }
}
