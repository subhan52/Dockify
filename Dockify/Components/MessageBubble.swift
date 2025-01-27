//
//  MessageBubble.swift
//  App_Duck
//
//  Created by Subhan on 12/7/24.
//

import SwiftUI
//
//struct MessageBubble: View {
//    var message: Message
//    @State private var showTime = false
//    
//    var body: some View {
//        VStack(alignment: message.received ? .leading : .trailing) {
//            HStack {
//                Text(message.text)
//                    .padding()
//                    .background(message.received ? Color("CustomGray") : Color("Peach"))
//                    .cornerRadius(30)
//            }
//            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
//            .onTapGesture {
//                showTime.toggle()
//            }
//            
//            if showTime {
//                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
//                    .font(.caption2)
//                    .foregroundColor(.gray)
//                    .padding(message.received ? .leading : .trailing, 25)
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
//        .padding(message.received ? .leading : .trailing)
//        .padding(.horizontal, 10)
//    }
//}
//
//struct MessageBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageBubble(message: Message(id: "12345", text: "I've been coding applications from scratch in SwiftUI and it's so much fun!", received: true, timestamp: Date()))
//    }
//}


import SwiftUI
import FirebaseAuth

struct MessageBubble: View {
    var message: Message
    @State private var showTime = false
    
    // Determine if the message is received or sent
    private var isReceived: Bool {
        // If the senderId is not the current user's uid, it's a received message
        return message.senderId != Auth.auth().currentUser?.uid
    }
    
    var body: some View {
        VStack(alignment: isReceived ? .leading : .trailing) {
            HStack {
                // Message content text
                Text(message.content)
                    .padding()
                    .background(isReceived ? Color("CustomGray") : Color("Peach"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: isReceived ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle() // Toggle time display on tap
            }
            
            // If `showTime` is true, display the timestamp
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(isReceived ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
        .padding(isReceived ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        // Sample message to preview the bubble
        MessageBubble(message: Message(
            id: "12345",
            senderId: "sender123",
            receiverId: "receiver456",
            content: "I've been coding applications from scratch in SwiftUI and it's so much fun!",
            timestamp: Date(),
            isRead: false,
            senderName: "John Doe",
            receiverName: "Jane Doe"))
    }
}
