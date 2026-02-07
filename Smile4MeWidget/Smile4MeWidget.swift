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
        let entry = JokeEntry(date: Date(), joke: Joke.twopart)
        completion(entry)
    }
    // dort werden die jokes gefetched die angezeigt werden
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [JokeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = JokeEntry(date: entryDate, joke: Joke.single)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct JokeEntry: TimelineEntry {
    let date: Date // das muss immer sein
    let joke: Joke?
}
// hier wird der Joke angezeigt
struct Smile4MeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            // content
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
