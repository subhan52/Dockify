//
//  HomeWidgetView.swift
//  App_Duck
//
//  Created by Bibhu Basnet on 11/26/24.
//

import SwiftUI

struct HomeWidgetView: View {
    let apps = [
        AppLauncher(name: "Messages", iconName: "message.fill", urlScheme: "sms:"),
        AppLauncher(name: "Email", iconName: "envelope.fill", urlScheme: "mailto:"),
        AppLauncher(name: "Calendar", iconName: "calendar", urlScheme: "calshow:"),
        AppLauncher(name: "Maps", iconName: "map", urlScheme: "http://maps.apple.com"),
        AppLauncher(name: "Photos", iconName: "photo.on.rectangle", urlScheme: "photos-redirect://"),
        AppLauncher(name: "Safari", iconName: "safari", urlScheme: "http://"),
        AppLauncher(name: "Notes", iconName: "note.text", urlScheme: "mobilenotes://"),
        AppLauncher(name: "Contacts", iconName: "person.3", urlScheme: "contacts:"),
        AppLauncher(name: "Weather", iconName: "cloud.sun.fill", urlScheme: "weather://"),
        AppLauncher(name: "Clock", iconName: "clock.fill", urlScheme: "clock:"),
        AppLauncher(name: "YouTube", iconName: "video.fill", urlScheme: "https://www.youtube.com/"),
        AppLauncher(name: "Spotify", iconName: "music.note", urlScheme: "https://open.spotify.com/"),
        AppLauncher(name: "Settings", iconName: "gear", urlScheme: "app-settings:") // Opens app settings
    ]

    let columns = [GridItem(.adaptive(minimum: 80, maximum: 100))] // Dynamically adjust to screen size

    var body: some View {
        ZStack {
            // Background Gradient to match AppDockView
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.8), Color.white.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            ScrollView { // Allow scrolling for smaller screens
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(apps) { app in
                        VStack {
                            Button(action: {
                                openApp(urlScheme: app.urlScheme)
                            }) {
                                Image(systemName: app.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50) // Adjusted icon size
                                    .padding(10)
                                    .background(Circle().fill(Color.white.opacity(0.3)).shadow(radius: 5))
                            }
                            Text(app.name)
                                .font(.caption)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .frame(maxWidth: 80)
                        }
                        .frame(width: 90, height: 110) // Adjusted card size
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black.opacity(0.2))
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        )
                        .padding(5)
                    }
                }
                .padding()
            }
        }
    }

    func openApp(urlScheme: String) {
        if let url = URL(string: urlScheme), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct AppLauncher: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let urlScheme: String
}

#Preview {
    HomeWidgetView()
}
