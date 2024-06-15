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
    
    static let store = Store(initialState: YogaCategoriesFeature.State()) {
        YogaCategoriesFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            YogaCategoriesListView(store: MyYogaPlanApp.store)
                .preferredColorScheme(.light)
        }
    }
}
