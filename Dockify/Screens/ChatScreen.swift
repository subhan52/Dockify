//
//  ChatScreen.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//

import SwiftUI
import FirebaseAuth

struct ChatScreen: View {
    @EnvironmentObject var firebaseService: FirebaseService  // Inject FirebaseService using @EnvironmentObject
    
    @State private var messages: [Message] = []
    @State private var newMessage = ""
    
    var receiverId: String
    var receiverName: String
    private var senderId: String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    private var senderName: String {
        Auth.auth().currentUser?.displayName ?? "Unknown User"
    }
    
    // Fetch messages from Firebase when the view appears
    func fetchMessages() {
        firebaseService.fetchMessages(for: senderId) { fetchedMessages, error in
            if let error = error {
                print("Error fetching messages: \(error.localizedDescription)")
                return
            }
            if let fetchedMessages = fetchedMessages {
                self.messages = fetchedMessages
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                // ScrollView to display messages
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messages.reversed()) { message in
                            MessageBubble(message: message)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.top, 10)
                    .background(Color.white)
                    .onAppear {
                        fetchMessages() // Fetch messages when the screen appears
                    }
                }
                
                // Message input field and send button
                MessageField(
                    receiverId: receiverId,
                    receiverName: receiverName,
                    onMessageSent: { content in
                        sendMessage(content: content)
                    }
                )
                .environmentObject(firebaseService)  // Pass FirebaseService down to the MessageField
            }
        }
        .background(Color("Peach"))
    }
    
    // Send the message
    func sendMessage(content: String) {
        guard !content.isEmpty else { return }
        
        // Create a new message object
        let newMessageObj = Message(
            senderId: senderId,
            receiverId: receiverId,
            content: content,
            senderName: senderName,
            receiverName: receiverName
        )
        
        // Send message using FirebaseService
        firebaseService.sendMessage(newMessageObj) { error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            } else {
                print("Message sent successfully!")
                fetchMessages() // Reload messages after sending
            }
        }
    }
}

#Preview {
    ChatScreen(receiverId: "receiver123", receiverName: "Jane Doe")
        .environmentObject(FirebaseService())  // Ensure FirebaseService is injected in the Preview
}

