//
//  ContentView.swift
//  Slot Machine
//
//  Created by Ivan Romero on 18/02/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    // MARK: - FUNCTIONS
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(colors: [.colorPink, .colorPurple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // MARK: - INTERFACE
            
            // MARK: - POPUP
            
            VStack(alignment: .center, spacing: 5) {
                // MARK: - HEADER
                LogoView()
                    .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
                
                // MARK: - SCORE
                HStack {
                    HStack(content: {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    })
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack(content: {
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    })
                    .modifier(ScoreContainerModifier())
                }
                
                // MARK: - SLOT MACHINE
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - REEL 1
                    ZStack {
                        ReelView()
                        Image(.gfxBell)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0, content: {
                        // MARK: - REEL 2
                        ZStack {
                            ReelView()
                            Image(.gfxSeven)
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL 3
                        ZStack {
                            ReelView()
                            Image(.gfxCherry)
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    })
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        
                    }, label: {
                        Image(.gfxSpin)
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                }
                .layoutPriority(2)
                
                // MARK: - FOOTER
                
                Spacer()
            }
            // MARK: - BUTTONS
            .overlay(alignment: .topLeading, content: {
                // RESET
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
            })
            .overlay(alignment: .topTrailing, content: {
                // INFO
                Button(action: {
                    
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
            })
            .padding()
            .frame(maxWidth: 720)
        }
        
    }
}

// MARK: - PREVIEW
#Preview {
    ContentView()
}
