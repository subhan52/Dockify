//
//  Message.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//

import Foundation

//struct Message: Identifiable, Codable {
//    var id: String
//    var text: String
//    var received: Bool
//    var timestamp: Date
//}

import Foundation
import FirebaseFirestore

struct Message: Identifiable, Codable {
    let id: String
    let senderId: String
    let receiverId: String
    let content: String
    let timestamp: Date
    let isRead: Bool
    
    // Optional: Include sender and receiver names for easy display
    let senderName: String
    let receiverName: String

    enum CodingKeys: String, CodingKey {
        case id
        case senderId
        case receiverId
        case content
        case timestamp
        case isRead
        case senderName
        case receiverName
    }

    init(id: String = UUID().uuidString,
         senderId: String,
         receiverId: String,
         content: String,
         timestamp: Date = Date(),
         isRead: Bool = false,
         senderName: String,
         receiverName: String) {
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.content = content
        self.timestamp = timestamp
        self.isRead = isRead
        self.senderName = senderName
        self.receiverName = receiverName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        senderId = try container.decode(String.self, forKey: .senderId)
        receiverId = try container.decode(String.self, forKey: .receiverId)
        content = try container.decode(String.self, forKey: .content)
        timestamp = try container.decode(Date.self, forKey: .timestamp)
        isRead = try container.decode(Bool.self, forKey: .isRead)
        senderName = try container.decode(String.self, forKey: .senderName)
        receiverName = try container.decode(String.self, forKey: .receiverName)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(senderId, forKey: .senderId)
        try container.encode(receiverId, forKey: .receiverId)
        try container.encode(content, forKey: .content)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(isRead, forKey: .isRead)
        try container.encode(senderName, forKey: .senderName)
        try container.encode(receiverName, forKey: .receiverName)
    }
}
