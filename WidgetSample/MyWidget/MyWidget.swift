//
//  MyWidget.swift
//  MyWidget
//
//  Created by Hangyeol on 10/18/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 10 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry
    @AppStorage("count", store: .appGroupShared) var count = 0

    var body: some View {
        VStack {
            HStack {
                Text("Time:")
                Text(entry.date, style: .time)
            }
            
            HStack {
                Text("Count:")
                
                Text("\(count)")
                    .font(.title3)
                    .contentTransition(.numericText(value: Double(count)))
                    .invalidatableContent()
            }
            
            HStack {
                Toggle(isOn: false, intent: CountUpIntent()) {
                    Image(systemName: "arrowshape.up.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                }
                .tint(.cyan)
                
                Toggle(isOn: false, intent: CountDownIntent()) {
                    Image(systemName: "arrowshape.down.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                }
                .tint(.red)
                
                Toggle(isOn: false, intent: CountResetIntent()) {
                    Image(systemName: "arrow.uturn.backward")
                        .resizable()
                        .frame(width: 10, height: 10)
                }
                .tint(.green)
            }
        }
    }
}

struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    MyWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
