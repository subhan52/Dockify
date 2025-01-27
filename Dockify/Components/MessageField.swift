import SwiftUI
import FirebaseAuth

struct MessageField: View {
    @State private var message = ""
    
    // Receiver's information (passed as parameters to the view)
    var receiverId: String
    var receiverName: String
    var onMessageSent: (String) -> Void // Closure to handle sending the message

    var body: some View {
        HStack {
            // Custom text field for entering the message
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
                .frame(height: 52)
                .disableAutocorrection(true)

            Button {
                onMessageSent(message) // Call the sendMessage function from parent view
                message = "" // Clear message after sending
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Peach"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("CustomGray"))
        .cornerRadius(50)
        .padding()
    }
}

#Preview{
    MessageField(receiverId: "someReceiverId", receiverName: "John Doe") { message in
        print("Message sent: \(message)")
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

