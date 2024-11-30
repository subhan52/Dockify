//
//  SplashScreen.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 11/26/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
struct SplashScreen: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var isLoggedIn = false
    init() {
        FirebaseApp.configure() // Initialize Firebase
    }

    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            VStack {
                if isLoggedIn {
                    AppDockView(isLoggedIn: $isLoggedIn) // Navigate to the main app screen after login
                } else {
                    WelcomeScreenView(isLoggedIn: $isLoggedIn) // Pass a binding to update login state
                }
                    
            }
        } else {
            VStack {
                VStack {
                    Image(systemName: "hare.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("DockiFY")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}

