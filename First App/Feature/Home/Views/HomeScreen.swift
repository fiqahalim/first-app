//
//  HomeScreen.swift
//  First App
//
//  Created by fiqahalim on 22/09/2023.
//

import SwiftUI

struct HomeScreen: View {
    
    // Calling sessions
    @EnvironmentObject var service: SessionServiceImpl
    
    @Binding var path: [HomeNavigation]
    
    var body: some View {
        
        NavigationStack(path: $path) {
            NavigationLink(value: HomeNavigation.child) {
                Text("Click me to navigate")
            }
            .padding(.horizontal, 16)
            .navigationDestination(for: HomeNavigation.self) { screen in
                switch screen {
                case .child: ChildView()
                case .secondChild(let person): SecondChildView(person: person)
                }
            }
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    service.logout()
                }
            }
        }
        .padding()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(path: .constant([HomeNavigation]()))
            .environmentObject(SessionServiceImpl())
    }
}
