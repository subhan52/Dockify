//
//  ContentView.swift
//  App_Duck
//
//  Created by Subhan on 11/26/24.
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
