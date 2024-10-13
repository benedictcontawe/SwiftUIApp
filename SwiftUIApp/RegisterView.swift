//
//  RegisterView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel : RegisterViewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack() {
            GeometryReader { geometry in
                ZStack {
                    Color.gray.edgesIgnoringSafeArea(.all)
                    VStack(spacing: CGFloat(geometry.size.height * 0.025)) {
                        Image(systemName: "swift")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: geometry.size.width * 0.4)
                            .foregroundColor(.orange)
                        HStack(alignment: .top) {
                            Image(systemName: "envelope").foregroundColor(.gray)
                            TextField("Email", text: $viewModel.email).autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        ZStack(alignment: .trailing) {
                            if viewModel.isPasswordHidden {
                                HStack(alignment: .top) {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.gray)
                                    SecureField("Password", text: $viewModel.password).autocapitalization(.none)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            } else {
                                HStack(alignment: .top) {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.gray)
                                    TextField("Password", text: $viewModel.password).autocapitalization(.none)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                            Button(action: {
                                viewModel.isPasswordHidden.toggle()
                            }) {
                                Image(systemName: viewModel.isPasswordHidden ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                        Button(action: { viewModel.onRegisterCredential() }) {
                            Text("Register")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .navigationDestination(isPresented: $viewModel.isRegistered, destination: { MainView().navigationBarBackButtonHidden(true) })
                        Button(action: {
                            print("Go to Login tapped")
                            dismiss()
                        }) {
                            Text("Go to Login")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.leading, geometry.size.width * 0.05)
                    .padding(.trailing, geometry.size.width * 0.05)
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
