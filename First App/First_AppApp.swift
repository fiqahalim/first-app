//
//  First_AppApp.swift
//  First App
//
//  Created by fiqahalim on 20/09/2023.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct First_AppApp: App {
    // register firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                    case .loggedIn:
                    TabScreenView()
                            .environmentObject(sessionService)
                    case .loggedOut:
                        LoginView()
                    }
                
            }
        }
    }
}
