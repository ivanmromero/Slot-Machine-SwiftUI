//
//  ReelView.swift
//  Slot Machine
//
//  Created by Ivan Romero on 18/02/2024.
//

import SwiftUI

struct ReelView: View {
    // MARK: - PROPERTIES
    // MARK: - FUNCTIONS
    // MARK: - BODY
    var body: some View {
        Image(.gfxReel)
            .resizable()
            .modifier(ImageModifier())

    }
}

// MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 220, height: 220)) {
    ReelView()
}
