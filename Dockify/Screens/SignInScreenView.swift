//
//  SignInScreenView.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct SignInScreenView: View {
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = "" // By default it's empty
    
    var body: some View {
        ZStack {
            Color("CustomGray").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    SocalLoginButton(
                        image: Image(uiImage: #imageLiteral(resourceName: "apple")),
                        text: Text("Sign in with Apple")
                    )

                    SocalLoginButton(
                        image: Image(uiImage: #imageLiteral(resourceName: "google")),
                        text: Text("Sign in with Google").foregroundColor(Color("CustomPrimaryColor"))
                    )
                    .padding(.vertical)

                    Text("or")

                    TextField("Email address", text: $email)
                        .applyInputStyle()
                        .keyboardType(.emailAddress) // Optimized for email entry
                        .autocapitalization(.none) // Starts with lowercase input
                    
                    SecureField("Password", text: $password) // Masks password input
                        .applyInputStyle()
                        .autocapitalization(.none) // Starts with lowercase input
                        .textContentType(.password) // Helps with autofill and password management
                        .padding(.bottom)

                    Button(action: { signIn() }) {
                        Text("Sign In")
                            .applyButtonStyle()
                    }
                    .navigationBarBackButtonHidden(true) // Hide back button in SignInScreenView
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
        }
    }

    // MARK: - Sign-In Logic
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = ""
                isLoggedIn = true // Update the binding to reflect login state
            }
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView(isLoggedIn: .constant(false))
    }
}

struct SocalLoginButton: View {
    var image: Image
    var text: Text

    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 60,
            x: 0.0, y: 16
        )
    }
}
