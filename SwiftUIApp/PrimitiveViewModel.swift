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
    
    private var primitives: [PrimitiveModel] = []
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
            get: { self.integerTextValue.description },
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
                  let id = document.documentID
                  let data = document.data()
                  print("fetchData document.data() \(data)")
                  if let boolean = data[Constants.BOOLEAN] as? Bool {
                      print("fetchData boolean:", boolean)
                      primitives.append(PrimitiveModel(id: id, data: boolean, type: Constants.BOOLEAN))
                      DispatchQueue.main.async {
                          self.booleanValue = boolean
                      }
                  }
                  if let string = data[Constants.STRING] as? String {
                      print("fetchData string:", string)
                      primitives.append(PrimitiveModel(id: id, data: string, type: Constants.STRING))
                      DispatchQueue.main.async {
                          self.stringValue = string
                      }
                  }
                  if let integer = data[Constants.INTEGER] as? Int {
                      print("fetchData integer:", integer)
                      primitives.append(PrimitiveModel(id: id, data: integer, type: Constants.INTEGER))
                      DispatchQueue.main.async {
                          self.integerValue = integer
                      }
                  }
                  if let double = data[Constants.DOUBLE] as? Double {
                      print("fetchData double:", double)
                      primitives.append(PrimitiveModel(id: id, data: double, type: Constants.DOUBLE))
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
    
    public func onUpdateBoolean() {
        print("Update Boolean tapped \(booleanValue)")
        onUpdateFirestoreCollection(
            filteredModel: primitives.first(where: { $0.type == Constants.BOOLEAN }),
            newData: toggleValue,
            type: Constants.BOOLEAN,
            onSuccess: {
                self.booleanValue = self.toggleValue
            }, onError: { error in
                self.onLogError(error: error)
            }
        )
    }
    
    public func onUpdateString() {
        print("Update String tapped \(stringValue)")
        onUpdateFirestoreCollection(
            filteredModel: primitives.first(where: { $0.type == Constants.STRING }),
            newData: stringTextValue,
            type: Constants.STRING,
            onSuccess: {
                self.stringValue = self.stringTextValue
            }, onError: { error in
                self.onLogError(error: error)
            }
        )
    }
    
    public func onUpdateInteger() {
        print("Update Integer tapped \(integerValue)")
        onUpdateFirestoreCollection(
            filteredModel: primitives.first(where: { $0.type == Constants.INTEGER }),
            newData: integerTextValue,
            type: Constants.INTEGER,
            onSuccess: {
                self.integerValue = self.integerTextValue
            }, onError: { error in
                self.onLogError(error: error)
            }
        )
    }
    
    public func onUpdateDouble() {
        print("Update Double tapped \(doubleValue)")
        onUpdateFirestoreCollection(
            filteredModel: primitives.first(where: { $0.type == Constants.DOUBLE }),
            newData: doubleTextValue,
            type: Constants.DOUBLE,
            onSuccess: {
                self.doubleValue = self.doubleTextValue
            }, onError: { error in
                self.onLogError(error: error)
            }
        )
        
    }
    
    private func onUpdateFirestoreCollection(filteredModel : PrimitiveModel?, newData : Any?, type : String, onSuccess: @escaping () -> Void, onError: @escaping (Error?) -> Void) {
        /*
        if let model = filteredModel {
            let updatedModel = PrimitiveModel(id: model.id, data: newData, type: type)
            let document = firestore.collection(Constants.PRIMITIVE).document(model.id!)
            document.updateData(updatedModel.toMap()) { error in
              if let _error = error {
                print("Error updating document: \(_error)")
                onError(_error)
              } else {
                print("Document successfully updated")
                onSuccess()
              }
            }
        }
        */
        guard let model = filteredModel else {
            print("onUpdateFirestoreCollection filteredModel is nil")
            return
        }
        let updatedModel = PrimitiveModel(id: model.id, data: newData, type: type)
        let document = firestore.collection(Constants.PRIMITIVE).document(model.id!)
        document.updateData(updatedModel.toMap()) { error in
          if let _error = error {
              print("onUpdateFirestoreCollection Error updating document: \(_error)")
              onError(_error)
          } else {
              print("Document successfully updated")
              onSuccess()
          }
        }
    }
    
    private func onLogError(error : Any?) {
        if let _error = error as? NSError {
            print("Error domain: \(_error.domain)")
            print("Error code: \(_error.code)")
            print("Error description: \(_error.localizedDescription)")
        } else {
            print("Unexpected error: \(String(describing: error))")
        }
    }
}
