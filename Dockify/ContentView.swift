//
//  ContentView.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 11/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
                    Color.blue
                        .ignoresSafeArea()
                    Text("ContentView")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .bold()
                        .padding()
                }
    }
}

#Preview {
    ContentView()
}
