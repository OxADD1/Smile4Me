//
//  ContentView.swift
//  Smile4Me_iOS
//
//  Created by Adrian Eberhardt on 04.02.26.
//




import SwiftUI

struct StartTabView: View {
    var body: some View {
        TabView {
            Tab("Jokes", systemImage: "face.smiling") {
                JokeContentView()
            }
            Tab("Info", systemImage: "info.circle") {
                Text("Joke Distribution")
            }
        }
    }
}

#Preview {
    StartTabView()
}
