//
//  testfile.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 12/15/24.
//
import Foundation
import SwiftUI

struct UserListView: View {
    @State private var users: [User] = []
    @State private var isLoading = false
    @State private var error: Error?

    let firebaseService = FirebaseService()

    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                HStack {
                    Text("\(user.firstName) \(user.lastName)")
                    Spacer()
                }
            }
            .navigationTitle("Users")
        }.onAppear(perform: fetchUsers)

    }

    func fetchUsers() {
        isLoading = true
        firebaseService.fetchUsers { fetchedUsers, fetchError in
            isLoading = false
            if let fetchedUsers = fetchedUsers {
                self.users = fetchedUsers
            } else if let fetchError = fetchError {
                self.error = fetchError
            }
        }
    }
}

#Preview {
    UserListView()
}
