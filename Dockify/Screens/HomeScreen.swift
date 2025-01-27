//
//  HomeScreen.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//
import SwiftUI
import FirebaseAuth

struct AppLauncher: Identifiable, Codable {
    var id = UUID()
    var name: String
    var iconName: String
    var urlScheme: String
}

struct HomeWidgetView: View {
    @State private var apps: [AppLauncher] = loadApps()
    @State private var searchText = ""

    @State private var showingAddAppDialog = false
    @State private var showingDeleteAppDialog = false
    @State private var selectedAppToDelete: AppLauncher? = nil
    @State private var newAppName = ""
    @State private var newAppIcon = ""
    @State private var newAppURLScheme = ""
    @StateObject private var firebaseService = FirebaseService()

    var columns = [GridItem(.adaptive(minimum: 80, maximum: 100))]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("CustomGray").opacity(0.8), Color.white.opacity(0.6),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    TextField("Search apps...", text: $searchText)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding([.horizontal, .top])

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(
                                apps.filter { app in
                                    searchText.isEmpty
                                        || app.name.lowercased().contains(
                                            searchText.lowercased())
                                }
                            ) { app in
                                if app.name != "Settings" {
                                    appTile(for: app)
                                }
                            }
                            VStack{
                                let user = Auth.auth().currentUser;
                                NavigationLink(
                                    destination: ChatScreen(
                                        receiverId: "user!.uid",
                                        receiverName: "Recipient"
                                    ).environmentObject(firebaseService)
                                    
                                ) {
                                    Image(systemName: "message.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(10)
                                        .background(
                                            Circle().fill(Color.white.opacity(0.3)).shadow(
                                                radius: 5))
                                }
                                Text("Group Chat")
                            }
                        }
                        .padding()
                    }
                }

                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: AppSettingsView(apps: $apps)
                        ) {
                            Image(systemName: "ellipsis.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(10)
                                .background(
                                    Circle().fill(Color.white.opacity(0.3))
                                        .shadow(radius: 5))
                        }
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.trailing, 20)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingAddAppDialog = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                                .background(
                                    Circle().fill(Color.white.opacity(0.3))
                                        .shadow(radius: 5))
                        }
                        .padding()
                    }

                    HStack {
                        Spacer()
                        Button(action: {
                            showingDeleteAppDialog = true
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                                .background(
                                    Circle().fill(Color.white.opacity(0.3))
                                        .shadow(radius: 5))
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Home Screen")
            .sheet(isPresented: $showingAddAppDialog) {
                AddAppView(
                    newAppName: $newAppName, newAppIcon: $newAppIcon,
                    newAppURLScheme: $newAppURLScheme, onAdd: addApp)
            }
            .sheet(isPresented: $showingDeleteAppDialog) {
                DeleteAppView(apps: $apps, selectedApp: $selectedAppToDelete)
            }
        }
    }

    func appTile(for app: AppLauncher) -> some View {
        VStack {
            Button(action: {
                openApp(urlScheme: app.urlScheme)
            }) {
                Image(systemName: app.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .background(
                        Circle().fill(Color.white.opacity(0.3)).shadow(
                            radius: 5))
            }

            Text(app.name)
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: 80)
        }
        .frame(width: 90, height: 110)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.2))
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        )
        .padding(5)
    }

    func openApp(urlScheme: String) {
        if let url = URL(string: urlScheme) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Cannot open URL scheme: \(urlScheme)")
            }
        }
    }

    func addApp() {
        let newApp = AppLauncher(
            name: newAppName, iconName: newAppIcon, urlScheme: newAppURLScheme)
        apps.append(newApp)
        saveApps()
        showingAddAppDialog = false
    }

    func deleteApp(app: AppLauncher) {
        if let index = apps.firstIndex(where: { $0.id == app.id }) {
            apps.remove(at: index)
            saveApps()
        }
        showingDeleteAppDialog = false
    }

    static func loadApps() -> [AppLauncher] {
        guard let data = UserDefaults.standard.data(forKey: "apps"),
            let apps = try? JSONDecoder().decode([AppLauncher].self, from: data)
        else {
            return [
                AppLauncher(name: "Messages", iconName: "message.fill",urlScheme: "sms:"),
                AppLauncher(name: "NEST", iconName: "shield.fill", urlScheme: "nest.montclair.edu/Montclair-State-University/montclair-landing")
            ]
        }
        return apps
    }

    func saveApps() {
        if let encoded = try? JSONEncoder().encode(apps) {
            UserDefaults.standard.set(encoded, forKey: "apps")
        }
    }
}

struct HomeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWidgetView()
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)
    }
}
