//
//  AppView.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            YogaCategoriesListView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Text("Categories")
                }
            
            FavoritePosesListView(
                store: store.scope(state: \.tab2, action: \.tab2)
            )
            .tabItem {
                Text("Favorites")
            }
        }
    }
}
