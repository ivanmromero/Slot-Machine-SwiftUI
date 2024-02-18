//
//  Extensions.swift
//  Slot Machine
//
//  Created by Ivan Romero on 18/02/2024.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundStyle(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundStyle(.white)
            .font(.system(.title, design: .rounded, weight: .heavy))
    }
    
    
}
