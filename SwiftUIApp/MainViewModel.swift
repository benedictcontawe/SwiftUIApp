//
//  MainViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/12/24.
//

import Foundation
import FirebaseAuth

class MainViewModel : ObservableObject {
    private let firebaseAuth = Auth.auth()
    func onLaunchPrimitive() {
        debugPrint("MainController onLaunchPrimitive");
        //TODO: Redirect to PrimitiveView
    }

    func onLaunchObject() {
        debugPrint("MainController onLaunchObject");
        //TODO: Redirect to ObjectView
    }
    
    func onSignOut() {
        do {
            debugPrint("MainController onSignOut");
            try firebaseAuth.signOut()
            //TODO: Redirect to LoginView
        } catch {
            print("MainViewModel onSignOut catch error: \(error.localizedDescription)")
        }
    }
}
