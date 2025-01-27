//
//  App_DuckApp.swift
//  App_Duck
//
//  Created by Subhan on 11/26/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import StreamChat
import StreamChatSwiftUI

@main
struct App_DuckApp: App {
    @State var isLoggedIn: Bool = true
    @State var streamChat: StreamChat?

    var chatClient: ChatClient = {
        //For the tutorial we use a hard coded api key and application group identifier
        var config = ChatClientConfig(apiKey: .init("8br4watad788"))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"

        // The resulting config is passed into a new `ChatClient` instance.
        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
        streamChat = StreamChat(chatClient: chatClient)
        connectUser()
    }

    var body: some Scene {
        WindowGroup {
            // Pass the isLoggedIn state to the SplashScreen and wrap it in a Binding
            SplashScreen(isLoggedIn: $isLoggedIn)
                .environmentObject(FirebaseService()).onAppear(perform: checkLoginStatus) // Inject FirebaseService
        }
    }
    // Function to check Firebase authentication status
        private func checkLoginStatus() {
            if Auth.auth().currentUser != nil {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    
    
    
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ.kFSLHRB5X62t0Zlc7nwczWUfsQMwfkpylC6jCUZ6Mc0")
        
        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
            userInfo: .init(
                id: "luke_skywalker",
                name: "Luke Skywalker",
                imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!
            ),
            token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
    
}
