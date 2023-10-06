//
//  LoginView.swift
//  First App
//
//  Created by fiqahalim on 21/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    // Declare variables
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    @StateObject private var viewModel = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
    
    var body: some View {
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
            
            VStack(spacing: 16) {
                
                VStack(spacing: 16) {
                    
                    Text("FoodHero connects merchants to consumers to quickly sell fresh surplus food that would otherwise end up in the trash")
                        .font(.system(size: 16, weight: .thin))
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    InputTextFieldView(text: $viewModel.credentials.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       systemImage: "envelope")
                    
                    InputPasswordView(password: $viewModel.credentials.password,
                                      placeholder: "Password",
                                      systemImage: "lock")
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        showForgotPassword.toggle()
                    }, label: {
                        Text("Forgot Password?")
                    })
                    .font(.system(size: 14, weight: .bold))
                    .sheet(isPresented: $showForgotPassword) {
                            ForgotPasswordView()
                    }
                }
                
                VStack(spacing: 16) {
                    
                    ButtonView(title: "Login") {
                        viewModel.login()
                    }
                    
                    ButtonView(title: "Register",
                               background: .clear,
                               foreground: .blue,
                               border: .blue) {
                        showRegistration.toggle()
                    }
                    .sheet(isPresented: $showRegistration) {
                            RegisterView()
                    }
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Login")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}

/**
 * Login Button view component
 */
struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    private let cornerRadius: CGFloat = 10
    
    internal init(title: String,
                  background: Color = .green,
                  foreground: Color = .white,
                  border: Color = .clear,
                  handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        
        Button(action: {
            handler()
        }, label: {
            Text(title)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
        })
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(border, lineWidth: 2)
        )
    }
}

/**
 * Textfield input view component
 */
struct InputTextFieldView: View {
    
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let systemImage: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        
        VStack {
            
            TextField(placeholder, text: $text)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: 44,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
                .keyboardType(keyboardType)
                .background(
                    
                    ZStack(alignment: .leading) {
                        
                        if let systemImage = systemImage {
                            
                            Image(systemName: systemImage)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.leading, 5)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        
                        RoundedRectangle(cornerRadius: 10,
                                         style: .continuous)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    }
                )
        }
    }
}

struct InputPasswordView: View {
    
    @Binding var password: String
    let placeholder: String
    let systemImage: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        
        VStack {
            
            SecureField(placeholder, text: $password)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: 44,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
                .background(
                    
                    ZStack(alignment: .leading) {
                        
                        if let systemImage = systemImage {
                            
                            Image(systemName: systemImage)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.leading, 5)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        
                        RoundedRectangle(cornerRadius: 10,
                                         style: .continuous)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    }
                )
        }
    }
}
