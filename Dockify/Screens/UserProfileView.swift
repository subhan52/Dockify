//
//  UserProfileView.swift
//  App_Duck
//
//  Created by Bibhu Basnet on 11/26/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserProfileView: View {
    @State private var firstName: String = "Loading..."
    @State private var lastName: String = "Loading..."
    @State private var email: String = "Loading..."
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Picture Section (Static)
                    Image(systemName: "person.crop.circle.fill") // Default placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 5)
                        .padding()

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
        }
    }

    private func fetchProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.firstName = data["firstName"] as? String ?? "No First Name"
                self.lastName = data["lastName"] as? String ?? "No Last Name"
                self.email = data["email"] as? String ?? "No Email"
            }
        }
    }

    private func saveProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(uid).updateData([
            "firstName": self.firstName,
            "lastName": self.lastName
        ]) { error in
            if let error = error {
                print("Failed to update profile: \(error.localizedDescription)")
            } else {
                print("Profile updated successfully")
            }
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
