//
//  AppDockView.swift
//  App_Duck
//
//  Created by Bibhu Basnet on 11/26/24.
//

import SwiftUI

struct AppDockView: View {
    @Binding var isLoggedIn: Bool // Binding to control login state

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.red.opacity(0.8), Color.red.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    // Logout Button
                    HStack {
                        Button(action: {
                            isLoggedIn = false // Set isLoggedIn to false to log out
                        }) {
                            HStack {
                                Image(systemName: "arrow.left.square.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title3)
                                Text("Logout")
                                    .foregroundColor(.yellow)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 10)

                    // Tab View
                    TabView {
                        HomeWidgetView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "house.fill")
                                    Text("Home")
                                }
                            }

                        ChatScreen()
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

                        SettingsView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "gearshape.fill")
                                    Text("Settings")
                                }
                            }
                    }
                    .accentColor(.black) // Change tab selection color
                    .background(
                        Color.white.opacity(0.1)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                    .padding(.bottom, 20) // Add some padding to the tab view
                }
            }
        }
    }
}

#Preview {
    AppDockView(isLoggedIn: .constant(true))
}
