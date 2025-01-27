//
//  FirebaseService.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 12/15/24.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var isLoggedIn = false

    // Published properties that can be observed by SwiftUI views
    @Published var messages: [Message] = []
    @Published var users: [User] = []
    
    // Fetch users
    func fetchUsers(completion: @escaping ([User]?, Error?) -> Void) {
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var users: [User] = []
            for document in querySnapshot!.documents {
                let data = document.data()
                let user = User(
                    id: document.documentID,
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    avatarName: data["avatarName"] as? String ?? "avatar1"
                )
                users.append(user)
            }
            self.users = users  // Update the @Published property
            completion(users, nil)
        }
    }
    
    // Send message
    func sendMessage(_ message: Message, completion: @escaping (Error?) -> Void) {
        do {
            let data = try Firestore.Encoder().encode(message)
            db.collection("messages").document(message.id).setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    // Fetch messages for a user
    func fetchMessages(for userId: String, completion: @escaping ([Message]?, Error?) -> Void) {
        db.collection("messages")
            .order(by: "timestamp", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }

                let messages = querySnapshot?.documents.compactMap { document -> Message? in
                    try? document.data(as: Message.self)
                }
                
                self.messages = messages ?? []  // Update the @Published property
                completion(messages, nil)
            }
    }

        func checkLoginStatus() {
            if let user = Auth.auth().currentUser {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
}
