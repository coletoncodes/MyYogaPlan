//
//  RoundedRectViewModifier.swift
//  MyYogaPlan
//
//  Created by Coleton Gorecke on 6/15/24.
//

import Foundation
import SwiftUI

fileprivate struct RoundedRectViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: lineWidth)
            }
    }
    
    // MARK: - Constants
    private let cornerRadius: CGFloat = 8.0
    private let lineWidth: CGFloat = 1.0
}

extension View {
    func roundedRectBackground() -> some View {
        self.modifier(RoundedRectViewModifier())
    }
}
