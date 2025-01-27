//
//  LoginView.swift
//  App_Duck
//
//  Created by Subhan on 11/26/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @Binding var isLoggedIn: Bool // Binding to manage login state

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: login) {
                Text("Sign In")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
        }
        .padding()
    }

    // Firebase Login Function
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = "Login failed: \(error.localizedDescription)"
                return
            }
            // If login is successful, set isLoggedIn to true
            isLoggedIn = true
        }
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(true))
}
