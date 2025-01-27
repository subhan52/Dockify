//
//  EditAppView.swift
//  App_Duck
//
//  Created by Subhan on 12/10/24.
//

import SwiftUI

struct EditAppView: View {
    // Binding properties for app name and icon
    @Binding var editedName: String
    @Binding var selectedIcon: String
    
    // Closure to handle the save action
    var onSave: () -> Void

    // Presentation mode for dismissing the view
    @Environment(\.presentationMode) var presentationMode
    
    // List of available icons for selection
    let availableIcons: [String] = [
        "app.fill", "star.fill", "heart.fill", "paperplane.fill", "envelope.fill", "leaf.fill", "flame.fill", "cloud.fill", "banknote.fill", "camera.fill", "calendar", "person.fill", "message.fill", "photo.on.rectangle",
        "map", "safari", "creditcard.fill", "note.text", "person.3", "cloud.sun.fill", "clock.fill"
    ]
    
    // State to track which icon is selected
    @State private var selectedIndex: Int?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit App Details")) {
                    // TextField to edit the app name
                    TextField("App Name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    // Button to trigger icon selection
                    Button(action: {
                        // Show a list of icons when the user clicks to change icon
                        selectedIndex = availableIcons.firstIndex(of: selectedIcon)
                    }) {
                        HStack {
                            Text("Select Icon")
                            Spacer()
                            Image(systemName: selectedIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }

                    // Scrollable list of icons to choose from when user presses select icon button
                    if let selectedIndex = selectedIndex {
                        Section(header: Text("Choose Icon")) {
                            ScrollView {
                                ForEach(availableIcons.indices, id: \.self) { index in
                                    Button(action: {
                                        selectedIcon = availableIcons[index]
                                        self.selectedIndex = nil // Close the icon picker after selection
                                    }) {
                                        HStack {
                                            Image(systemName: availableIcons[index])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .padding()
                                                .background(selectedIndex == index ? Color.blue.opacity(0.3) : Color.clear) // Highlight selection
                                                .cornerRadius(10)

                                            Text(availableIcons[index])
                                                .font(.body)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .frame(height: 300) // Adjust the height to control the scrollable area
                           .scrollIndicators(.visible) // Make the scrollbar visible
                         
                        }
                    }
                }

                Section {
                    // Save button
                    Button("Save") {
                        onSave() // Save the changes
                        presentationMode.wrappedValue.dismiss() // Go back to the previous screen
                    }
                    .foregroundColor(.blue)

                    // Cancel button
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss() // Go back without saving
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit App")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss() // Go back to the previous screen
            })
        }
    }
}

struct EditAppView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the EditAppView with sample data
        EditAppView(editedName: .constant("Messages"),
                    selectedIcon: .constant("message.fill"),
                    onSave: { /* Your save action here */ })
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light) // Use light mode for preview
            .padding()
    }
}
