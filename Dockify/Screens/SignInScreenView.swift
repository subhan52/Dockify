import FirebaseAuth
import FirebaseFirestore
//
//  SignInScreenView.swift
//  login
import SwiftUI

struct SignInScreenView: View {
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""// by default it's empty
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    SocalLoginButton(
                        image: Image(
                            uiImage: #imageLiteral(resourceName: "apple")),
                        text: Text("Sign in with Apple"))

                    SocalLoginButton(
                        image: Image(
                            uiImage: #imageLiteral(resourceName: "google")),
                        text: Text("Sign in with Google").foregroundColor(
                            Color("PrimaryColor"))
                    )
                    .padding(.vertical)

                    Text("or")

                    TextField("Email address", text: $email)
                        .applyInputStyle()
                    TextField("password", text: $password)
                        .applyInputStyle()
                        .padding(.bottom)
                    Button(action: {signIn()}){
                        Text("Sign In")
                            .applyButtonStyle()
                    }
//                    NavigationLink(
//                        destination: ChatScreen(),
//                        label: {
//                            Text("Sign In")
//                                .font(.title3).applyButtonStyle()
//                        }
//                    )
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
            color: Color.black.opacity(0.08), radius: 60,
            x: /*@START_MENU_TOKEN@*/ 0.0 /*@END_MENU_TOKEN@*/, y: 16)
    }
}
