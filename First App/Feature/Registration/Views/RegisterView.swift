//
//  RegisterView.swift
//  First App
//
//  Created by fiqahalim on 21/09/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl()
    )
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.green
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                Image("Logo1")
                
                VStack(spacing: 32) {
                    
                    VStack(spacing: 16) {
                        
                        InputTextFieldView(text: $viewModel.newUser.firstName,
                                           placeholder: "First Name",
                                           keyboardType: .namePhonePad,
                                           systemImage: "person")
                        
                        InputTextFieldView(text: $viewModel.newUser.lastName,
                                           placeholder: "Last Name",
                                           keyboardType: .namePhonePad,
                                           systemImage: "person")
                        
                        InputTextFieldView(text: $viewModel.newUser.email,
                                           placeholder: "Email",
                                           keyboardType: .emailAddress,
                                           systemImage: "envelope")
                        
                        InputPasswordView(password: $viewModel.newUser.password,
                                          placeholder: "Password",
                                          systemImage: "lock")
                        
                        InputTextFieldView(text: $viewModel.newUser.role,
                                           placeholder: "Select Role",
                                           keyboardType: .namePhonePad,
                                           systemImage: "person.badge.key")
                    }
                    
                    ButtonView(title: "Sign up") {
                        viewModel.create()
                    }
                }
                .padding(.horizontal, 15)
                .navigationTitle("Register")
                .applyClose()
                .alert(isPresented: $viewModel.hasError,
                       content: {
                        
                        if case .failed(let error) = viewModel.state {
                            return Alert(
                                title: Text("Error"),
                                message: Text(error.localizedDescription))
                        } else {
                            return Alert(
                                title: Text("Error"),
                                message: Text("Something went wrong"))
                        }
                })
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
            RegisterView()
    }
}
