//
//  YogaCategoryDetailView.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/14/24.
//

import Foundation
import ComposableArchitecture
import MyYogaCore
import SwiftUI

struct YogaCategoryDetailView: View {
    let store: StoreOf<YogaCategoryDetailFeature>
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Section {
                        Text(store.category.description)
                            .font(.body)
                    } header: {
                        Text("Description")
                            .font(.headline)
                    }
                    
                    Rectangle()
                        .fill(.black)
                        .frame(height: 2)
                        .padding(.vertical)
                    
                    Section {
                        ForEach(store.poses) { pose in
                            PoseCellView(pose: pose)
                                .padding(.vertical)
                        }
                    } header: {
                        Text("Poses")
                            .font(.headline)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(store.category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct PoseCellView: View {
    let pose: YogaPose
    
    var body: some View {
        VStack {
            Text(pose.name)
                .font(.headline)
                .padding(.bottom)
            
            AsyncImage(url: URL(string: pose.urlPNG)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Failed to load image")
                } else {
                    Image(systemName: "photo.artframe.circle.fill")
                        .scaledToFit()
                        .overlay {
                            ProgressView()
                                .tint(.black)
                        }
                }
            }
            
            // Pose Benefits
            ForEach(pose.benefits, id: \.hashValue) { benefit in
                HStack {
                    Label(benefit, systemImage: "chevron.right.circle.fill")
                        .font(.body)
                    
                    Spacer()
                }
            }
            .padding(.vertical)
        }
        .padding()
        .roundedRectBackground()
    }
}

#Preview {
    YogaCategoryDetailView(
        store: .init(
            initialState: YogaCategoryDetailFeature.State.init(
                category: .init(
                    id: 1,
                    name: "Preview Category",
                    description: "Some description",
                    poses: Array(
                        repeating: .init(
                            id: 1,
                            name: "English Name",
                            description: "Some description",
                            urlPNG: "",
                            benefits: Array(repeating: "Some benefit", count: 5)
                        ),
                        count: 10
                    )
                )
            )
        )
        {
            YogaCategoryDetailFeature()
        }
    )
}
