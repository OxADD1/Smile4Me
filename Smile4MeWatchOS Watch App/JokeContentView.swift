//
//  ContentView.swift
//  Smile4MeWatchOS Watch App
//
//  Created by Adrian on 09.02.26.
//

import SwiftUI

struct JokeContentView: View {
    let jokeManager = JokeManager()
    @State private var joke: Joke?
    @State private var fetching = false
    @State private var errorString = ""
    var body: some View {
        NavigationStack {
            if fetching{
                ProgressView()
            }else {
                ScrollView {
                    VStack {
                        if let joke {
                            JokeView(joke: joke)
                        } else {
                            ContentUnavailableView {
                                Text("🥲")
                                    .font(.system(size: 50))
                            } description: {
                                Text(errorString)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Smile4Me")
            }
            
        }
        .task {
            await getJoke()
        }
    }

    func getJoke() async {
        errorString = ""
        fetching.toggle()
        defer {
            fetching.toggle()
        }
        do {
            let joke = try await jokeManager.getJoke()
            withAnimation {
                self.joke = joke
            }
        } catch {
            joke = nil
            errorString = "No joke available"
        }
    }

}

#Preview {
    JokeContentView()
}
