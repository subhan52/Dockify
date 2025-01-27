//
//  AppDockView.swift
//  App_Duck
//
//  Created by Subhan on 11/26/24.
//

import SwiftUI

    struct AppDockView: View {
        @Binding var isLoggedIn: Bool  // Binding to control login state
        @StateObject private var firebaseService = FirebaseService()

        var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        // Tab View
                        TabView {
                            HomeWidgetView()
                                .tabItem {
                                    VStack {
                                        Image(systemName: "house.fill")
                                        Text("Home")
                                    }
                                }

                            StreamChatChannels()
                                .tabItem {
                                    VStack {
                                        Image(systemName: "message.fill")
                                        Text("Chat")
                                    }
                                }

                            MusicPlayerView()
                                .tabItem {
                                    VStack {
                                        Image(systemName: "music.note")
                                        Text("Music")
                                    }
                                }

                            // User Profile Tab
                            UserProfileView()
                                .tabItem {
                                    VStack {
                                        Image(systemName: "person.crop.circle.fill")
                                        Text("Profile")
                                    }
                                }

                            SettingsView(isLoggedIn: $isLoggedIn)
                                .tabItem {
                                    VStack {
                                        Image(systemName: "gearshape.fill")
                                        Text("Settings")
                                    }
                                }
                        }
                        .accentColor(.black)  // Change tab selection color
                        .background(
                            Color.white.opacity(0.1)
                                .cornerRadius(20)
                                .shadow(
                                    color: .black.opacity(0.2), radius: 10, x: 0,
                                    y: 5)
                        )// Add some padding to the tab view
                    }
                }
            }
        }
    }

    #Preview {
        AppDockView(isLoggedIn: .constant(true))
    }
