//
//  MainViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/12/24.
//

import Foundation

class MainViewModel : ObservableObject {
    func onLaunchPrimitive() {
        debugPrint("MainController onLaunchPrimitive");
        //TODO: Redirect to PrimitiveView
    }

    func onLaunchObject() {
        debugPrint("MainController onLaunchObject");
        //TODO: Redirect to ObjectView
    }
}
