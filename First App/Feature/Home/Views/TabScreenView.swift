//
//  TabScreenView.swift
//  First App
//
//  Created by fiqahalim on 22/09/2023.
//

import SwiftUI

// Enum for Tabs, add other tabs if needed
enum Tab {
    case home, donates, settings
}

enum HomeNavigation: Hashable {
    case child, secondChild(Person)
}

struct TabScreenView: View {
    
    // Calling sessions
    @EnvironmentObject var service: SessionServiceImpl
    
    // Declare navigationStacks for each of the tabs
    @State private var selectedTab: Tab = .home
    @State private var homeNavigationStack: [HomeNavigation] = []
    
    var body: some View {
        TabView(selection: tabSelection()) {
            HomeScreen(path: $homeNavigationStack)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            
            GoalsView()
                .tabItem {
                    Label("Donate", systemImage: "takeoutbag.and.cup.and.straw.fill")
                }
                .tag(Tab.donates)
            
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
    }
}

extension TabScreenView {
    private func tabSelection() -> Binding<Tab> {
        Binding { // This is the get block
            self.selectedTab
        } set: { tappedTab in
            if tappedTab == self.selectedTab {
                // User tapped on the tab twice == Pop to root view
                if homeNavigationStack.isEmpty {
                    // User already on home view, scroll to top
                } else {
                    homeNavigationStack = []
                }
            }
            // Set the tab to the tabbed tab
            self.selectedTab = tappedTab
        }
    }
}

struct TabScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreenView()
            .environmentObject(SessionServiceImpl())
    }
}
