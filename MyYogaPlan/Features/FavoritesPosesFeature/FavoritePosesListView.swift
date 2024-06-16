//
//  FavoritePosesListView.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import SwiftUI
import ComposableArchitecture

struct FavoritePosesListView: View {
    @Bindable var store: StoreOf<FavoritePosesFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                ScrollView {
                    ForEach(Array(store.favoritePoses)) { favoritePose in
                        PoseCellView(pose: favoritePose) { pose in
                            store.send(.didFavoritePose(pose))
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Favorite Poses")
            }
        }
    }
}
