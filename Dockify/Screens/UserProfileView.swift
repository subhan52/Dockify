//
//  UserProfileView.swift
//  App_Duck
//
//  Created by Subhan on 11/26/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserProfileView: View {
    @State private var firstName: String = "John"
    @State private var lastName: String = "Doe"
    @State private var email: String = "john.doe@example.com"
    @State private var avatarName: String = "avatar1" // Default avatar
    @State private var isEditing: Bool = false
    @State private var showAvatarPicker = false

    // Explicitly list avatars
    let avatars = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Picture Section
                    Image(avatarName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 5)
                        .padding()
                        .onTapGesture {
                            showAvatarPicker = true // Open avatar picker
                        }

                    // Profile Information
                    VStack(spacing: 15) {
                        ProfileField(placeholder: "First Name", text: $firstName, isEditing: $isEditing)
                        ProfileField(placeholder: "Last Name", text: $lastName, isEditing: $isEditing)
                        ProfileField(placeholder: "Email", text: $email, isEditing: .constant(false)) // Email is non-editable
                    }
                    .padding(.horizontal, 20)

                    // Edit/Save Button
                    Button(action: {
                        isEditing.toggle()
                        if !isEditing {
                            saveProfile()
                        }
                    }) {
                        Text(isEditing ? "Save" : "Edit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isEditing ? Color.green : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical, 30)
            }
            .navigationTitle("User Profile")
            .onAppear(perform: fetchProfile)
            .sheet(isPresented: $showAvatarPicker) {
                AvatarPicker(selectedAvatar: $avatarName, showPicker: $showAvatarPicker, avatars: avatars)
            }
        }
    }

    public func fetchProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.firstName = data["firstName"] as? String ?? "No First Name"
                self.lastName = data["lastName"] as? String ?? "No Last Name"
                self.email = data["email"] as? String ?? "No Email"
                self.avatarName = data["avatarName"] as? String ?? "avatar1" // Load avatar from Firestore
            }
        }
    }

    private func saveProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(uid).updateData([
            "firstName": self.firstName,
            "lastName": self.lastName,
            "avatarName": self.avatarName // Save selected avatar
        ]) { error in
            if let error = error {
                print("Failed to update profile: \(error.localizedDescription)")
            } else {
                print("Profile updated successfully")
            }
        }
    }
}

struct AvatarPicker: View {
    @Binding var selectedAvatar: String
    @Binding var showPicker: Bool // To dismiss the picker after selection
    let avatars: [String]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
                    ForEach(avatars, id: \.self) { avatar in
                        VStack {
                            Image(avatar)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                                .onTapGesture {
                                    selectedAvatar = avatar // Update selected avatar
                                    showPicker = false // Dismiss picker after selection
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose Avatar")
        }
    }
}

struct ProfileField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isEditing: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder)
                .font(.headline)
                .foregroundColor(.gray)
            if isEditing {
                TextField(placeholder, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
            } else {
                Text(text)
                    .font(.body)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    UserProfileView()
}
