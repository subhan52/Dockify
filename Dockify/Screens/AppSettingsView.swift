//
//  SwiftUIView.swift
//  App_Duck
//
//  Created by Subhan on 12/10/24.
//
import SwiftUI

struct AppSettingsView: View {
    @Binding var apps: [AppLauncher]
    @State private var selectedApp: AppLauncher?
    @State private var editedName: String = ""
    @State private var selectedIcon: String = "app.fill"

    var body: some View {
        NavigationView {
            List {
                ForEach(apps) { app in
                    AppRow(app: app)
                        .onTapGesture {
                            selectedApp = app
                            editedName = app.name
                            selectedIcon = app.iconName
                        }
                }
            }
            .navigationTitle("App Settings")
            .listStyle(InsetGroupedListStyle()) // Enhanced list style
            .sheet(item: $selectedApp) { app in
                EditAppView(
                    editedName: $editedName,
                    selectedIcon: $selectedIcon,
                    onSave: {
                        updateApp(app: app)
                    }
                )
            }
        }
    }

    func updateApp(app: AppLauncher) {
        if let index = apps.firstIndex(where: { $0.id == app.id }) {
            apps[index].name = editedName
            apps[index].iconName = selectedIcon
            saveApps()
        }
    }

    func saveApps() {
        if let encoded = try? JSONEncoder().encode(apps) {
            UserDefaults.standard.set(encoded, forKey: "apps")
        }
    }
}

// Refactored AppRow to break up the complex view
struct AppRow: View {
    var app: AppLauncher

    var body: some View {
        HStack {
            appIcon
            appName
            Spacer()
            editButton
        }
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }

    private var appIcon: some View {
        Image(systemName: app.iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(5)
            .background(Circle().fill(Color.blue.opacity(0.2))) // Use Circle() for rounded background
    }

    private var appName: some View {
        Text(app.name)
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.leading, 10)
    }

    private var editButton: some View {
        Text("Edit")
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.1)) // Fill with color first
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue.opacity(0.4), lineWidth: 1) // Outline with stroke
                    )
            )
    }
}

// Mock data for the preview
struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockApps = [
            AppLauncher(name: "Messages", iconName: "message.fill", urlScheme: "sms:"),
            AppLauncher(name: "Email", iconName: "envelope.fill", urlScheme: "mailto:"),
            AppLauncher(name: "Calendar", iconName: "calendar", urlScheme: "calshow:"),
            AppLauncher(name: "Safari", iconName: "safari", urlScheme: "http://"),
            AppLauncher(name: "Settings", iconName: "gear", urlScheme: "app-settings:")
        ]
        
        AppSettingsView(apps: .constant(mockApps))
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)
    }
}
