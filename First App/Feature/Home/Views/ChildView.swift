//
//  ChildView.swift
//  First App
//
//  Created by fiqahalim on 22/09/2023.
//

import SwiftUI

struct ChildView: View {
    // Should try to display the user's name from session
    let person = Person(name: "Fiqa", lastName: "Halim")
    
    var body: some View {
        VStack {
                    Text("Child View")
                    
                    NavigationLink(value: HomeNavigation.secondChild(person)) {
                        Text("Click to enter second view")
                    }
                }
                .navigationTitle("Child")
    }
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChildView()
        }
    }
}
