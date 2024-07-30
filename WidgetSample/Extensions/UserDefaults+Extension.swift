//
//  UserDefaults+Extension.swift
//  WidgetSample
//
//  Created by Hangyeol on 7/30/24.
//

import Foundation

extension UserDefaults {
    static var appGroupShared: UserDefaults {
        let appGroupID = "group.io.gyeolee.widgetsample"
        return UserDefaults(suiteName: appGroupID)!
    }
}
