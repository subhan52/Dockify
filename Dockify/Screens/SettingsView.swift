//
//  SettingsView.swift
//  App_Duck
//
//  Created by Bibhu Basnet on 11/26/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false // Theme toggle
    @State private var notificationsEnabled = true // Notification toggle
    @State private var isLoggedOut = false // For logout action

    var body: some View {
        NavigationView {
            Form {
                // Theme Section
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                }

                // Notification Section
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                }

                // Account Settings Section
                Section(header: Text("Account Settings")) {
                    NavigationLink(destination: AccountSettingsView()) {
                        Text("Manage Account")
                    }
                }

                // General Settings Section
                Section(header: Text("General")) {
                    NavigationLink(destination: AppInformationView()) {
                        Text("App Information")
                    }

                    Button(action: {
                        isLoggedOut = true
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                // Save any settings or preferences if needed
            })
            .background(isDarkMode ? Color.black : Color.white) // Change background based on the theme
            .preferredColorScheme(isDarkMode ? .dark : .light) // Apply dark/light mode
        }
        .alert(isPresented: $isLoggedOut) {
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Log Out")) {
                    // Handle logout functionality here
                    print("User logged out")
                },
                secondaryButton: .cancel()
            )
        }
    }
}

// Subview for Account Settings
struct AccountSettingsView: View {
    var body: some View {
        VStack {
            Text("Account Settings")
                .font(.title)
                .padding()

            // Here, you can add further account management options like changing the password, email, etc.
            Text("User Profile Details")
        }
        .navigationBarTitle("Account Settings", displayMode: .inline)
    }
}

// Subview for App Information
struct AppInformationView: View {
    var body: some View {
        VStack {
            Text("App Information")
                .font(.title)
                .padding()

            Text("Version 1.0")
            Text("Developed by Your Company")
            Text("Contact: support@yourcompany.com")
        }
        .navigationBarTitle("App Info", displayMode: .inline)
    }
}

