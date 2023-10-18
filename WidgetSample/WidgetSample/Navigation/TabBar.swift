//
//  TabBar.swift
//  WidgetSample
//
//  Created by Hangyeol on 10/18/23.
//

import SwiftUI

enum Tab: CaseIterable {
    case widget
    case liveActivity
    
    var title: String {
        switch self {
        case .widget:       return "Widget"
        case .liveActivity: return "Live Activity"
        }
    }
    
    var color: Color {
        switch self {
        case .widget:       return .blue
        case .liveActivity: return .green
        }
    }
    
    var iconName: String {
        switch self {
        case .widget:       "1.circle"
        case .liveActivity: "2.circle"
        }
    }
}

struct TabBar: View {
    @Binding var selectedTab: Tab
    
    @State private var tabWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom - 88 > 20
            
            HStack {
                tabButtons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 88 : 62, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 34 : 0, style: .continuous))
            .background(background)
            .overlay(overlay)
            .strokeStyle(cornerRadius: hasHomeIndicator ? 34 : 0)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    var tabButtons: some View {
        ForEach(Tab.allCases, id: \.self) { tab in
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = tab
                }
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: tab.iconName)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44, height: 29)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundColor(selectedTab == tab ? .primary : .secondary)
            .blendMode(selectedTab == tab ? .overlay : .normal)
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            }
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tabWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .liveActivity { Spacer() }
            Circle().fill(selectedTab.color).frame(width: tabWidth)
            if selectedTab == .widget { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .liveActivity { Spacer() }
            Rectangle()
                .fill(selectedTab.color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .widget { Spacer() }
        }
        .padding(.horizontal, 8)
    }
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    @State var selectedTab: Tab = .widget
    return TabBar(selectedTab: $selectedTab)
}
