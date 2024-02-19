//
//  InfoView.swift
//  Slot Machine
//
//  Created by Ivan Romero on 18/02/2024.
//

import SwiftUI

struct InfoView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    // MARK: - FUNCTIONS
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form(content: {
                Section {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "Iphone, Ipad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Ivan Manuel Romero")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                } header: {
                    Text("About the application")
                }
            })
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            })
            .padding(.top, 30)
            .padding(.trailing, 20)
            .tint(.secondary)
        }
    }
}

struct FormRowView: View {
    let firstItem: String
    let secondItem: String
    
    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text(secondItem)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    InfoView()
}
