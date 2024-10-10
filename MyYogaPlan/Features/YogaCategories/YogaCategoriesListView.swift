//
//  YogaCategoriesListView.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import SwiftUI
import ComposableArchitecture

struct YogaCategoriesListView: View {
    @Bindable var store: StoreOf<YogaCategoriesFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(
                path: $store.scope(state: \.path, action: \.path)
            ) {
                ScrollView {
                    ForEach(store.categories) { category in
                        YogaCategoryCellView(category: category)
                            .onTapGesture {
                                store.send(.didSelectCategory(category))
                            }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Yoga Categories")
                .overlay {
                    if store.isLoading {
                        ProgressView()
                    }
                }
                .onAppear {
                    store.send(.fetchCategories)
                }
            } destination: { store in
                YogaCategoryDetailView(store: store)
            }
        }
    }
}


fileprivate struct YogaCategoryCellView: View {
    let category: YogaCategory
    
    // MARK: - Body
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(category.name)
                        .font(.title)
                    
                    Spacer()
                }
                
                HStack {
                    Text(category.description)
                        .font(.body)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .padding()
            
            Spacer()
            
            Label("", systemImage: "chevron.right")
                .padding(.trailing)
        }
        .padding()
    }
}

#Preview {
    YogaCategoriesListView(
        store: Store(
            initialState: YogaCategoriesFeature.State()
        ) {
            YogaCategoriesFeature()
        }
    )
}
