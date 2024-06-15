//
//  CategoryDetailView.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct CategoryDetailView: View {
    let store: StoreOf<SelectCategoryFeature>
    
    var body: some View {
        ScrollView {
            VStack {
                Section {
                    Text(store.category.categoryDescription)
                        .font(.body)
                } header: {
                    Text("Description")
                        .font(.headline)
                }
                
                Section {
                    ForEach(store.poses) { pose in
                        Text(pose.englishName)
                    }
                } header: {
                    Text("Poses")
                }
                
            }
            .padding()
        }
    }
}
