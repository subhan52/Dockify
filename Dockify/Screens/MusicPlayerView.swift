//
//  MusicPlayerView.swift
//  App_Duck
//
//  Created by Bibhu Basnet on 11/26/24.
//

import SwiftUI

struct MusicPlayerView: View {
    var body: some View {
        ZStack {
            // Background gradient for visual appeal
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.8), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Title and Apple Music logo
                Image(systemName: "music.note.house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .shadow(radius: 10)

                Text("Apple Music")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 5)

                Text("Launching Apple Music...")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))

                // Button to open Apple Music
                Button(action: {
                    openAppleMusic()
                }) {
                    Text("Open Apple Music")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            openAppleMusic() // Automatically try to open Apple Music when the view appears
        }
    }

    func openAppleMusic() {
        let appleMusicURL = "music://"
        if let url = URL(string: appleMusicURL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let webURL = "https://music.apple.com"
            if let webURL = URL(string: webURL), UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.open(webURL)
            } else {
                print("Unable to open Apple Music.")
            }
        }
    }
}

#Preview {
    MusicPlayerView()
}
