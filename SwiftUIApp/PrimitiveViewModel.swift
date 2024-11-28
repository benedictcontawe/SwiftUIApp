//
//  Primitive.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/28/24.
//

import SwiftUI
import FirebaseFirestore

class PrimitiveViewModel : ObservableObject {
    let firestore = Firestore.firestore()
    
    @Published public var toggleValue: Bool = false
    @Published public var stringTextValue: String = ""
    @Published public var integerTextValue: Int = 0
    @Published public var doubleTextValue: Double = 0.00
    
    @Published public var booleanValue: Bool = false
    @Published public var stringValue: String = ""
    @Published public var integerValue: Int = 0
    @Published public var doubleValue: Double = 0.00
    
    public func getBoolean() -> String {
        return booleanValue ? "true" : "false"
    }
    
    public func getToggle() -> String {
        return toggleValue ? "true" : "false"
    }
    
    public var integerTextValueBinding: Binding<String> {
        Binding(
            get: {
                self.integerTextValue.description
            },
            set: { newValue in
                if let integerValue = Int(newValue) {
                    self.integerTextValue = integerValue
                }
            }
        )
    }
    
    public func getDoubleText() -> Binding<String> {
        return Binding (
            get: { self.doubleTextValue.description },
            set: { newValue in
                if let doubleValue = Double(newValue) {
                    self.doubleTextValue = doubleValue
                }
            }
        )
    }
    
    public func fetchData() {
        Task {
            if let querySnapshot = try? await firestore.collection("primitive").getDocuments() {
              for document in querySnapshot.documents {
                  let data = document.data()
                  print("fetchData document.data() \(data)")
                  if let boolean = data[Constants.BOOLEAN] as? Bool {
                      print("fetchData boolean:", boolean)
                      DispatchQueue.main.async {
                          self.booleanValue = boolean
                      }
                  }
                  if let string = data[Constants.STRING] as? String {
                      print("fetchData string:", string)
                      DispatchQueue.main.async {
                          self.stringValue = string
                      }
                  }
                  if let integer = data[Constants.INTEGER] as? Int {
                      print("fetchData integer:", integer)
                      DispatchQueue.main.async {
                          self.integerValue = integer
                      }
                  }
                  if let double = data[Constants.DOUBLE] as? Double {
                      print("fetchData double:", double)
                      DispatchQueue.main.async {
                          self.doubleValue = double
                      }
                  }
              }
            } else {
              print("Error fetching data")
            }
        }
    }
    
    public func onUpdateBoolean() { //TODO: Update Boolean to Firebase Firestore
        print("Update Boolean tapped \(booleanValue)")
    }
    
    public func onUpdateString() { //TODO: Update String to Firebase Firestore
        print("Update String tapped \(stringValue)")
    }
    
    public func onUpdateInteger() { //TODO: Update Integer to Firebase Firestore
        print("Update Integer tapped \(integerValue)")
    }
    
    public func onUpdateDouble() { //TODO: Update Double to Firebase Firestore
        print("Update Double tapped \(doubleValue)")
    }
}
