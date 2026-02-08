import WidgetKit
import SwiftUI















struct ConfigurableWidgetProvider: AppIntentTimelineProvider {
    let jokeManager = JokeManager()
    func placeholder(in context: Context) -> ConfigurableEntry {
        ConfigurableEntry(
            date: Date(),
            configuration: ConfigurationAppIntent(),
            joke: Joke.single
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ConfigurableEntry {
        let joke = try? await jokeManager.getJoke()
        return ConfigurableEntry(
            date: Date(),
          configuration: configuration, joke: joke
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ConfigurableEntry> {
        var entries: [ConfigurableEntry] = []
        let currentDate = Date()
        let category = Category.allCases.first(
            where: {$0.rawValue == configuration.categoty?.id
            }) ?? .Any
        let language = Language.allCases.first(
            where: {$0.full == configuration.language?.id
            }) ?? .en
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let joke = try? await jokeManager.getJoke(category: category, language: language)
            let entry = ConfigurableEntry(
                date: entryDate,
                configuration: configuration,
                joke: joke
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct ConfigurableEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let joke: Joke?
}

struct ConfigurableWidgetEntryView : View {
    var entry: ConfigurableWidgetProvider.Entry
    @Environment(\.widgetFamily) var familiy
    var body: some View {
        if let joke = entry.joke {
            JokeView(joke: joke)
        } else {
            let category = entry.configuration.categoty?.id ?? Category.Any.rawValue
            let language = entry.configuration.language?.id ?? Language.en.full
            ContentUnavailableView {
                Text("🥲")
                    .font(.system(size: familiy == .systemLarge ? 120 : 80))
            } description: {
                Text("No joke available for \(category) in \(language)")
                    .font(familiy == .systemLarge ? .largeTitle : .title2)
                    .fixedSize(horizontal: false, vertical: true)
            }

        }
    }
}

struct ConfigurableWidget: Widget {
    let kind: String = "ConfigurableWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: ConfigurableWidgetProvider()) { entry in
            ConfigurableWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Configurable Widget")
        .description("Das ist ein Template für eine configurierebares Widget")
        // hier können auch noch weitere Größen ins array rein das was halt benötigt wird an Widgets
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}


#Preview("Medium Widget Template", as: .systemMedium) {
    ConfigurableWidget()
} timeline: {
    ConfigurableEntry(
        date: .now,
        configuration: ConfigurationAppIntent(),
        joke: Joke.single
    )
    ConfigurableEntry(
        date: .now,
        configuration: ConfigurationAppIntent(),
        joke: Joke.twopart
    )
}
#Preview("Large Widget Template", as: .systemLarge) {
    ConfigurableWidget()
} timeline: {
    ConfigurableEntry(
        date: .now,
        configuration: ConfigurationAppIntent(),
        joke: Joke.single
    )
    ConfigurableEntry(
        date: .now,
        configuration: ConfigurationAppIntent(),
        joke: Joke.twopart
    )
}
