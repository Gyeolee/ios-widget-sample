//
//  LiveActivityView.swift
//  WidgetSample
//
//  Created by Hangyeol on 10/18/23.
//

import SwiftUI
import ActivityKit

struct LiveActivityView: View {
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Button("Add Live Activity") {
                    let activityAttributes = MyWidgetAttributes(name: "My Widget")
                    let contentState = MyWidgetAttributes.ContentState(emoji: "🤩")
                    let activityContent = ActivityContent(state: contentState, staleDate: .now + 4)
                    
                    do {
                        let activity = try Activity<MyWidgetAttributes>.request(attributes: activityAttributes, content: activityContent)
                        print(activity)
                    } catch {
                        print(error)
                    }
                }
                
                Button("Remove Live Activity") {
                    let activities = Activity<MyWidgetAttributes>.activities
                    activities.forEach { activity in
                        let contentState = MyWidgetAttributes.ContentState(emoji: "😀")
                        let activityContent = ActivityContent(state: contentState, staleDate: .now + 4)
                        Task {
                            await activity.end(activityContent, dismissalPolicy: .immediate)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LiveActivityView()
}
