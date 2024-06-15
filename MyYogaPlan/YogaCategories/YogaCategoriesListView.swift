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
            NavigationStack {
                ScrollView {
                    ForEach(store.categories) { category in
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
                            
                            Button {
                                store.send(.selectCategory(category))
                            } label: {
                                Label("", systemImage: "chevron.right")
                                    .labelStyle(.iconOnly)
                            }
                            .padding()
                            .foregroundStyle(.black)
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(lineWidth: 1.0)
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Yoga Categories")
                .alert(isPresented: .constant(store.errorMessage != nil)) {
                    Alert(
                        title: Text("Error"),
                        message: Text(store.errorMessage ?? ""),
                        dismissButton: .default(
                            Text("OK"))
                    )
                }
                .onAppear {
                    store.send(.fetchCategories)
                }
            }
        }
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
