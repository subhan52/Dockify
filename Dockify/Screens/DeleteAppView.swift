//
//  DeleteAppView.swift
//  App_Duck
//
//  Created by Subhan on 12/10/24.
//

// DeleteAppView.swift
import SwiftUI

struct DeleteAppView: View {
    @Binding var apps: [AppLauncher]
    @Binding var selectedApp: AppLauncher?

    var body: some View {
        NavigationView {
            List {
                ForEach(apps) { app in
                    Button(action: {
                        selectedApp = app
                    }) {
                        HStack {
                            Image(systemName: app.iconName)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(app.name)
                        }
                    }
                    .background(
                        selectedApp?.id == app.id ? Color.blue.opacity(0.2) : Color.clear
                    )
                    .cornerRadius(8)
                }
            }
            .navigationTitle("Select App to Delete")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Delete") {
                        if let appToDelete = selectedApp {
                            deleteApp(app: appToDelete)
                        }
                    }
                }
            }
        }
    }

    func deleteApp(app: AppLauncher) {
        if let index = apps.firstIndex(where: { $0.id == app.id }) {
            apps.remove(at: index)
            saveApps()
        }
    }

    func saveApps() {
        if let encoded = try? JSONEncoder().encode(apps) {
            UserDefaults.standard.set(encoded, forKey: "apps")
        }
    }
}
