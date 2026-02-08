//
//  Smile4MeWidget.swift
//  Smile4MeWidget
//
//  Created by Adrian on 07.02.26.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    // dieser placeholder ist wenn das widget ist nicht verfügbar zb wenn es fetched
    func placeholder(in context: Context) -> JokeEntry {
        JokeEntry(date: Date(), joke: Joke.single)
    }
    // das ist das Preview beim hinzufügen oder editieren des widgets
    func getSnapshot(in context: Context, completion: @escaping (JokeEntry) -> ()) {
        let jokeManager = JokeManager()
        Task {
            let joke = try await jokeManager.getJoke()
            let entry = JokeEntry(date: Date(), joke: joke)
            completion(entry)
        }

    }
    // dort werden die jokes gefetched die angezeigt werden
    // es generiert eine timeline von entries und wann es upgaedet werden soll
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let jokeManager = JokeManager()
        var entries: [JokeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            // das ist asyncron deswegen ein Task
            Task {
                let joke = try await jokeManager.getJoke()
                let entry = JokeEntry(date: entryDate, joke: joke)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            }

        }


    }

}

struct JokeEntry: TimelineEntry {
    let date: Date // das muss immer sein
    let joke: Joke?
}


// hier wird der Joke angezeigt
struct Smile4MeWidgetEntryView : View {
    // um herauszufinden welches Widget benutzt wird für die schriftgröße
    @Environment(\.widgetFamily) var familiy
    
    var entry: Provider.Entry

    var body: some View {
        if let joke = entry.joke {
            Link(
                destination: URL(
                    string: "s4m://joke/\(joke.id)-\(joke.category.rawValue)-\(joke.lang.rawValue)"
                )!
            ) {
                JokeView(joke: joke)
            }
        } else {
            ContentUnavailableView {
                Text("🥲")
                    .font(.system(size: familiy == .systemLarge ? 120 : 80))
            } description: {
                Text("No joke available")
                    .font(familiy == .systemLarge ? .largeTitle : .title2)
            }

        }
    }
}

struct Smile4MeWidget: Widget {
    let kind: String = "Smile4MeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            
                Smile4MeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Smile4Me") // display name
        .description("Bring a smile to your face.")
        .supportedFamilies([.systemMedium, .systemLarge]) //verschiedene größen
    }
}

#Preview("Medium Widget", as: .systemMedium) {
    Smile4MeWidget()
} timeline: {
    JokeEntry(date: .now, joke: Joke.single)
    JokeEntry(date: .now, joke: Joke.twopart)
}

#Preview("Large Widget", as: .systemLarge) {
    Smile4MeWidget()
} timeline: {
    JokeEntry(date: .now, joke: Joke.single)
    JokeEntry(date: .now, joke: Joke.twopart)
}
