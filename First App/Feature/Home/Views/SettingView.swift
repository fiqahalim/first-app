//
//  SettingView.swift
//  First App
//
//  Created by fiqahalim on 22/09/2023.
//

import SwiftUI

struct SettingView: View {
    
    // Calling sessions
    @EnvironmentObject var service: SessionServiceImpl
    
    var body: some View {
        Text("Change Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(SessionServiceImpl())
    }
}
