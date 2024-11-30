//
//  CustomStyleModifier.swift
//  Dockify
//
//  Created by Mohd Abdul Subhan on 11/26/24.
//

import SwiftUI

struct CustomStyleModifier: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).applyInputStyle()
    }
}

#Preview {
    CustomStyleModifier()
}


// Modifier for Text Style
struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.black)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
}

// Modifier for Text Style
struct NavigationBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("PrimaryColor"))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(50.0)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            .padding(.vertical)
    }
}

// Modifier for Button Style
struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}

// Modifier for Button Style
struct InputStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(50.0)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}
    
extension View {
    func applyTextStyle() -> some View {
        self.modifier(TextStyle())
    }
    
    func applyInputStyle() -> some View {
        self.modifier(InputStyle())
    }
    
    func applyButtonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
    func applyNavigationStyle() -> some View {
        self.modifier(NavigationBarStyle())
    }
}
