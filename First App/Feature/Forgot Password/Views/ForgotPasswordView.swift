//
//  ForgotPasswordView.swift
//  First App
//
//  Created by fiqahalim on 21/09/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel = ForgotPasswordViewModelImpl(
        service: ForgotPasswordServiceImpl()
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
            
                InputTextFieldView(text: $viewModel.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   systemImage: "envelope")
                
                ButtonView(title: "Send Password Reset") {
                    viewModel.sendPasswordResetRequest()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Reset Password")
            .applyClose()
        }
    }
}

#Preview {
    ForgotPasswordView()
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
