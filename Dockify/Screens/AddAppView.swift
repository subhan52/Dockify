//
//  AddAppView.swift
//  App_Duck
//
//  Created by Subhan on 12/10/24.
//

// AddAppView.swift
import SwiftUI

struct AddAppView: View {
    @Binding var newAppName: String
    @Binding var newAppIcon: String
    @Binding var newAppURLScheme: String
    var onAdd: () -> Void

    // Predefined list of SF Symbols
    let sfSymbols = [
        "message.fill", "star.fill", "heart.fill", "paperplane.fill", "envelope.fill", "calendar", "map", "leaf.fill", "flame.fill", "cloud.fill", "banknote.fill", "camera.fill", "photo.on.rectangle",
        "safari", "note.text", "person.3", "cloud.sun.fill", "clock.fill",
        "video.fill", "music.note", "gear","shield.fill"
    ]

    @State private var selectedIcon: String?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("App Details")) {
                    // TextField for app name
                    TextField("App Name", text: $newAppName)

                    // Icon Selection Section
                    VStack(alignment: .leading) {
                        Text("App Icon (SF Symbol)")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(sfSymbols, id: \.self) { symbol in
                                    Button(action: {
                                        selectedIcon = symbol
                                        newAppIcon = symbol
                                    }) {
                                        Image(systemName: symbol)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .padding()
                                            .background(
                                                selectedIcon == symbol
                                                    ? Color.blue.opacity(0.3)
                                                    : Color.clear
                                            )
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }

                    // TextField for URL scheme
                    TextField("URL Scheme", text: $newAppURLScheme)
                        .keyboardType(.URL)
                }

                // Live Preview Section
                Section(header: Text("Preview")) {
                    HStack {
                        if let icon = selectedIcon {
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                        } else {
                            Text("No icon selected")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(newAppName.isEmpty ? "No Name" : newAppName)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }

                // Add App Button
                Section {
                    Button(action: {
                        onAdd()
                    }) {
                        Text("Add App")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(newAppName.isEmpty || newAppIcon.isEmpty || newAppURLScheme.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(newAppName.isEmpty || newAppIcon.isEmpty || newAppURLScheme.isEmpty)
                }
            }
            .navigationTitle("Add New App")
        }
    }
}
