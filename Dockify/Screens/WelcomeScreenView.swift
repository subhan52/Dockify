//
//  WelcomeScreenView.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//
import SwiftUI
import FirebaseAuth
import Firebase

struct WelcomeScreenView: View {
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationStack { // Use NavigationStack instead of NavigationView
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image(uiImage: #imageLiteral(resourceName: "onboard"))
                    Spacer()

                    NavigationLink(
                        destination: SignInScreenView(isLoggedIn: $isLoggedIn),
                        label: {
                            Text("Get Started")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("CustomPrimaryColor"))
                                .cornerRadius(50)
                                .shadow(
                                    color: Color.black.opacity(0.08),
                                    radius: 60, x: 0.0, y: 16)
                        }
                    )
                    .navigationBarHidden(true) // Hide back button

                    Text("Already have an account?")
                    NavigationLink(
                        destination: SignInScreenView(isLoggedIn: $isLoggedIn),
                        label: {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color("CustomPrimaryColor"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(
                                    color: Color.black.opacity(0.08),
                                    radius: 60, x: 0.0, y: 16
                                )
                                .padding(.vertical)
                        }
                    )
                    .navigationBarHidden(true) // Hide back button

                    HStack {
                        Text("New around here? ")
                        NavigationLink(
                            destination: SignUpScreenView(isLoggedIn: .constant(false)),
                            label: {
                                Text("Create an account").foregroundColor(
                                    Color("CustomPrimaryColor"))
                            })
                    }
                }
                .padding()
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView(isLoggedIn: .constant(true))
    }
}
