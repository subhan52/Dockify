//
//  ChatScreen.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 11/26/24.
//

import SwiftUI

struct ChatScreen: View {
    let messages: [Message] = [
          Message(id: "1", text: "Hey! How's it going?", received: false, timestamp: Date()),
          Message(id: "2", text: "Hey! I'm good, how about you?", received: true, timestamp: Date()),
          Message(id: "3", text: "I'm doing well, thanks for asking!", received: false, timestamp: Date()),
          Message(id: "4", text: "That's great! What have you been up to?", received: true, timestamp: Date()),
          Message(id: "5", text: "Not much, just working on some projects. How about you?", received: false, timestamp: Date()),
          Message(id: "6", text: "Same here, just finishing some work before the weekend.", received: true, timestamp: Date())
      ]
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                ScrollViewReader { proxy in
                    ScrollView {
                        // scrol through message array
                        ForEach(messages) { message in
                                        MessageBubble(message: message)
                                            .padding(.bottom, 10)
                                    }
                        MessageBubble(message: Message (id:"12345", text: "skjbd", received: true, timestamp: Date.now ))
                    }
                    .padding(.top, 10)
                    .background(.white)
                }
                MessageField()
            }
        }
        .background(Color("Peach"))
}
}

#Preview {
    ChatScreen()
}
