//
//  HomeView.swift
//  First App
//
//  Created by fiqahalim on 21/09/2023.
//

import SwiftUI

struct test: View {
    
    // Create views that rely on shared data
    @EnvironmentObject var service: SessionServiceImpl
    
    // Declare variable
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        NavigationStack {
            Spacer()
            Spacer()
            List {
                VStack(alignment: .leading,
                       spacing: 16) {
                    
                    VStack(alignment: .leading,
                           spacing: 16) {
                        Text("First Name: \(service.userDetails?.firstName ?? "N/A")")
                        Text("Last Name: \(service.userDetails?.lastName ?? "N/A")")
                        Text("Role: \(service.userDetails?.role ?? "N/A")")
                    }
                        
                        ButtonView(title: "Logout") {
                            service.logout()
                        }
                    
                }
                .padding(.horizontal, 16)
            }
            
            .navigationTitle("Welcome!")
            .toolbar {
                Button("Settings") {}
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.green,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            test()
                .environmentObject(SessionServiceImpl())
        }
    }
}
