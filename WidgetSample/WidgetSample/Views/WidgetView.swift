//
//  WidgetView.swift
//  WidgetSample
//
//  Created by Hangyeol on 10/18/23.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    @AppStorage("count", store: .appGroupShared) var count = 0
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Button("Reload Timelines") {
                    reloadTimelines()
                }
                
                Button("Reload All Timelines") {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                Text("\(count)")
                    .font(.title3)
                    .contentTransition(.numericText(value: Double(count)))
                
                HStack {
                    Button {
                        count = count + 1
                        reloadTimelines()
                    } label: {
                        Image(systemName: "arrowshape.up.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .tint(.cyan)
                    
                    Button {
                        count = count - 1
                        reloadTimelines()
                    } label: {
                        Image(systemName: "arrowshape.down.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .tint(.red)
                    
                    Button {
                        count = 0
                        reloadTimelines()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .tint(.green)
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

extension WidgetView {
    func reloadTimelines() {
        WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
    }
}

#Preview {
    WidgetView()
}
