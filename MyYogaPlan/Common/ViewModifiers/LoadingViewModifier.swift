//
//  LoadingContentViewModifier.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation
import SwiftUI

fileprivate struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .opacity(isLoading ? 0.5 : 1.0)
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
    }
}

extension View {
    func progressView(isShowing: Bool) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isShowing))
    }
}
