//
//  LoginView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 9/11/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordHidden: Bool = true
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
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
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            TextField("Email", text: $email)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        ZStack(alignment: .trailing) {
                            HStack(alignment: .top) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                if isPasswordHidden {
                                    SecureField("Password", text: $password)
                                } else {
                                    TextField("Password", text: $password)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            Button(action: {
                                isPasswordHidden.toggle()
                            }) {
                                Image(systemName: isPasswordHidden ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                        Button(action: {
                            print("Login tapped")
                        }) {
                            Text("Login")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        NavigationLink(destination: RegisterView()) {
                            Text("Go to Register")
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
    LoginView()
}
