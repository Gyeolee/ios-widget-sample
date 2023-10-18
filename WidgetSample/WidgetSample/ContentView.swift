//
//  ContentView.swift
//  WidgetSample
//
//  Created by Hangyeol on 10/18/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
            } label: {
                Text("Reload Timelines")
            }
            
            Button {
                WidgetCenter.shared.reloadAllTimelines()
            } label: {
                Text("Reload All Timelines")
            }
        }
        .padding()
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
    ContentView()
}
