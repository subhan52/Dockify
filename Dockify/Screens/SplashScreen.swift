//
//  SplashScreen.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//
import SwiftUI
import FirebaseAuth

struct SplashScreen: View {
    @Binding var isLoggedIn: Bool // Binding to manage login state across views
    @State private var isActive = false // Controls the transition from splash to the next view

    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            // Navigate to the appropriate screen based on the login state
            if (isLoggedIn == true) {
                AppDockView(isLoggedIn: $isLoggedIn) // Main app screen
            } else {
                WelcomeScreenView(isLoggedIn: $isLoggedIn) // Login screen
            }
        } else {
            VStack {
                VStack {
                    Image(systemName: "hare.fill") // Replace with your app logo
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("DockiFY")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    // Animation for scaling and fading the logo
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                // Check the login status asynchronously and update the UI when done
                checkLoginStatus()

                // Transition to the next screen only after login status is checked
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Shorter delay before transitioning
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }

    // Function to check the login status using Firebase Authentication
    private func checkLoginStatus() {
        // Check if the user is logged in asynchronously
        if let user = Auth.auth().currentUser {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
}
