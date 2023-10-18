//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by Hangyeol on 10/18/23.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetLiveActivity()
    }
}
