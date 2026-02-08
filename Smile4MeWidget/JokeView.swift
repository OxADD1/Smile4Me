//
//  JokeView.swift
//  Smile4MeWidgetExtension
//
//  Created by Adrian on 07.02.26.
//

import SwiftUI






struct JokeView: View {
    let joke: Joke
    var body: some View {
        HStack(alignment: .top) {
            Text(joke.category.emoji)
                .font(.system(size: 60))
            Text(joke.fullJoke)
                .font(.largeTitle)
                .lineLimit(nil)
                .minimumScaleFactor(0.2)
            Spacer()
        }
        // gesamter view
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

