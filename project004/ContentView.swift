//
//  ContentView.swift
//  project004
//
//  Created by user250318 on 9/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationStack {
                  LoginView()
                    .navigationTitle("Sign up")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
