//
//  JokeView.swift
//  Smile4MeWatchOS Watch App
//
//  Created by Adrian on 09.02.26.
//

import SwiftUI

struct JokeView: View {
    let joke: Joke
    var body: some View {
        HStack(alignment: .top) {
            Text(joke.category.emoji)
                .font(.system(size: 40))
            Text(joke.fullJoke)
                .lineLimit(nil)
            Spacer()
        }
    }
}

#Preview {
    JokeView(joke: Joke.twopart)
}
