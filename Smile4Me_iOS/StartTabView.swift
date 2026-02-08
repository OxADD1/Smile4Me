//
//  ContentView.swift
//  Smile4Me_iOS
//
//  Created by Adrian Eberhardt on 04.02.26.
//









import SwiftUI

struct StartTabView: View {
    @Environment(Router.self) var router
    var body: some View {
        TabView(selection: Bindable(router).selectesTab) {
            Tab("Jokes", systemImage: "face.smiling", value: 0) {
                JokeContentView()
            }
            Tab("Info", systemImage: "info.circle", value: 1) {
                Text("Joke Distribution")
            }
        }
    }
}

#Preview {
    StartTabView()
        .environment(Router())
}
