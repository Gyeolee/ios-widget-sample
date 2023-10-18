//
//  WidgetView.swift
//  WidgetSample
//
//  Created by Hangyeol on 10/18/23.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Button("Reload Timelines") {
                    WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
                }
                
                Button("Reload All Timelines") {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
        .onAppear {
            WidgetCenter.shared.getCurrentConfigurations { result in
                switch result {
                case .success(let widgets):
                    widgets.forEach {
                        print("kind: \($0.kind), family: \($0.family)")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    WidgetView()
}
