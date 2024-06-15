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
                .progressView(isShowing: store.isLoading)
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
                    Text(category.categoryName)
                        .font(.title)
                    
                    Spacer()
                }
                
                HStack {
                    Text(category.categoryDescription)
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
        .roundedRectBackground()
        .padding()
    }
    
    // MARK: - Constants
    private let cornerRadius: CGFloat = 8.0
    private let lineWidth: CGFloat = 1.0
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
