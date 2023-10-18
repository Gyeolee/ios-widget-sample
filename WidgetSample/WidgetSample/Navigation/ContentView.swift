//
//  ContentView.swift
//  WidgetSample
//
//  Created by Hangyeol on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .widget
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .widget:
                WidgetView()
                
            case .liveActivity:
                LiveActivityView()
            }
            
            TabBar(selectedTab: $selectedTab)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 88)
        }
        .dynamicTypeSize(.large ... .xxLarge)
    }
}

#Preview {
    ContentView()
}
