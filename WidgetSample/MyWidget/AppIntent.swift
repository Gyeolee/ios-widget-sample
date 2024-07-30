//
//  AppIntent.swift
//  MyWidget
//
//  Created by Hangyeol on 10/18/23.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

extension ConfigurationAppIntent {
    static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

struct CountUpIntent: AppIntent {
    static var title: LocalizedStringResource = "Count Up"
    
    func perform() async throws -> some IntentResult {
        let count = UserDefaults.appGroupShared.integer(forKey: "count")
        UserDefaults.appGroupShared.set(count + 1, forKey: "count")
        WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
        return .result()
    }
}

struct CountDownIntent: AppIntent {
    static var title: LocalizedStringResource = "Count Down"
    
    func perform() async throws -> some IntentResult {
        let count = UserDefaults.appGroupShared.integer(forKey: "count")
        UserDefaults.appGroupShared.set(count - 1, forKey: "count")
        WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
        return .result()
    }
}

struct CountResetIntent: AppIntent {
    static var title: LocalizedStringResource = "Count Reset"
    
    func perform() async throws -> some IntentResult {
        UserDefaults.appGroupShared.set(0, forKey: "count")
        WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
        return .result()
    }
}
