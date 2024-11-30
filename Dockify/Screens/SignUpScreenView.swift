//
//  SignUpScreenView.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 11/30/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SignUpScreenView: View {
    @Binding var isLoggedIn: Bool // Binding to update login state in the parent view
    @State private var firstName = "" // First Name Field
    @State private var lastName = ""  // Last Name Field
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = "" // New state for confirm password
    @State private var isSignUp = false
    @State private var errorMessage = ""// by default it's empty
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    TextField("First Name", text: $firstName)
                        .applyInputStyle()
                    TextField("Last Name", text: $lastName)
                        .applyInputStyle()
                    TextField("Email address", text: $email)
                        .applyInputStyle()
                    SecureField("Password", text: $password).applyInputStyle()
                    SecureField("Confirm Password",text: $confirmPassword).applyInputStyle()
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                    }
                    NavigationLink(
                        destination: ChatScreen(),
                        label: {
                            Text("Sign Up")
                                .font(.title3).applyButtonStyle().padding()
                        }
                    )
                    .navigationBarHidden(false)
                }

                Spacer()
                Divider()
                Spacer()
                Text("You are completely safe.")
                Text("Read our Terms & Conditions.")
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()

            }
            .padding()
        }
    }
    // MARK: - Clear Fields
    private func clearFields() {
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        confirmPassword = ""
        errorMessage = ""
    }
    
    // MARK: - Sign-Up Logic
    private func signUp() {
        if password != confirmPassword {
            self.errorMessage = "Passwords do not match!"
            return
        }

        // Create user in Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if let uid = authResult?.user.uid {
                // Save additional user data to Firestore
                let db = Firestore.firestore()
                db.collection("users").document(uid).setData([
                    "firstName": self.firstName,
                    "lastName": self.lastName,
                    "email": self.email
                ]) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    } else {
                        self.clearFields()
                        self.errorMessage = "Sign Up Successful! Please Login."
                        isSignUp = false
                    }
                }
            }
        }
    }
}
#Preview {
    SignUpScreenView(isLoggedIn: .constant(false))
}
