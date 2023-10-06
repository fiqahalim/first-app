//
//  NavigationCloseViewModifier.swift
//  First App
//
//  Created by fiqahalim on 21/09/2023.
//

import SwiftUI

struct NavigationCloseViewModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
    }
}

extension View {
    
    func applyClose() -> some View {
        self.modifier(NavigationCloseViewModifier())
    }
}
