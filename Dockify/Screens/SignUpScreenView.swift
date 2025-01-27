//
//  SignUpScreenView.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpScreenView: View {
    @Binding var isLoggedIn: Bool // Binding to update login state in the parent view
    @State private var firstName = "" // First Name Field
    @State private var lastName = ""  // Last Name Field
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = "" // Confirm Password Field
    @State private var errorMessage = "" // Error Message
    @State private var isProcessing = false // Prevent multiple taps
    @State private var showSuccessAlert = false // State to trigger success alert

    var body: some View {
        NavigationStack {
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
                        SecureField("Password", text: $password)
                            .applyInputStyle()
                        SecureField("Confirm Password", text: $confirmPassword)
                            .applyInputStyle()

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                        }

                        Button(action: {
                            signUp()
                        }) {
                            Text("Sign Up")
                                .font(.title3)
                                .applyButtonStyle()
                                .padding()
                        }
                        .disabled(isProcessing) // Disable when processing
                    }

                    Spacer()
                    Divider()
                    Spacer()
                    Text("You are completely safe.")
                    Text("Read our Terms & Conditions.")
                        .foregroundColor(Color("CustomPrimaryColor"))
                    Spacer()
                }
                .padding()
                .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text("Success!"),
                        message: Text("Sign Up Successful! Please Login."),
                        dismissButton: .default(Text("OK")) {
                            // Navigate to login after dismissing the alert
                            isLoggedIn = true
                        }
                    )
                }
            }
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
        isProcessing = true

        if password != confirmPassword {
            self.errorMessage = "Passwords do not match!"
            isProcessing = false
            return
        }
// this creates a user with email and password
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isProcessing = false
            } else if let uid = authResult?.user.uid {
                let db = Firestore.firestore()
                db.collection("users").document(uid).setData([
                    "firstName": self.firstName,
                    "lastName": self.lastName,
                    "email": self.email
                ]) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        self.isProcessing = false
                    } else {
                        DispatchQueue.main.async {
                            self.clearFields()
                            self.showSuccessAlert = true // Trigger the alert
                        }
                        self.isProcessing = false
                    }
                }
            }
        }
    }
}

#Preview {
    SignUpScreenView(isLoggedIn: .constant(false))
}
