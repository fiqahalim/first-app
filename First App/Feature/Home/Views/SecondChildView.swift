//
//  SecondChildView.swift
//  First App
//
//  Created by TSMM034 on 22/09/2023.
//

import SwiftUI

struct SecondChildView: View {
    
    let person: Person
    
    var body: some View {
        VStack(spacing: 10) {
                    Text("Welcome \(person.name) \(person.lastName) to")
                    Text("Second child view")
                        .fontWeight(.bold)
                    Text("of the Home View")
                }
                .navigationTitle("Second Child")
    }
}

struct SecondChildView_Previews: PreviewProvider {
    static var previews: some View {
        let person = Person(name: "Fiqa", lastName: "Halim")
        SecondChildView(person: person)
    }
}
