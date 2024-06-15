//
//  MyYogaPlanApp.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct MyYogaPlanApp: App {
    
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: MyYogaPlanApp.store)
                .preferredColorScheme(.light)
        }
    }
}
