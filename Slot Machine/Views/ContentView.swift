//
//  ContentView.swift
//  Slot Machine
//
//  Created by Ivan Romero on 18/02/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    let symbols: [ImageResource] = [.gfxBell, .gfxCherry, .gfxCoin, .gfxGrape, .gfxSeven, .gfxStrawberry]
    
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmoumt: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal:Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    // MARK: - FUNCTIONS
    // SPIN THE REELS
    private func spinReels() {
        reels = reels.map { _ in
            Int.random(in: 0...symbols.count - 1)
        }
    }
    
    // CHECK THE WINNING
    private func checkWinning() {
        switch allEqualUsingSet(array: reels) {
        case true:
            // PLAYER WINS
            playerWins()
            // NEW HIGHSCORE
            newHighscore()
        case false:
            // PLAYER LOSES
            playerLoses()
        }
    }
    
    private func allEqualUsingSet<T : Hashable>(array : [T]) -> Bool {
        let uniqueElements = Set(array)
        return uniqueElements.count <= 1
    }
    
    private func playerWins() {
        coins += betAmoumt * 10
    }
    
    private func newHighscore() {
        if coins > highscore {
            highscore = coins
            UserDefaults.standard.set(highscore, forKey: "HighScore")
        }
    }
    
    private func playerLoses() {
        coins -= betAmoumt
    }
    
    private func activateBet20() {
        betAmoumt = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    
    private func activateBet10() {
        betAmoumt = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    // GAME IS OVER
    private func isGameOver() {
        if coins <= 0 {
            // SHOW MODAL
            showingModal = true
        }
    }
    
    // RESET GAME
    private func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
    }
    
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
                    .padding(.top, 10)
                Spacer()
                
                // MARK: - SCORE
                HStack {
                    HStack(content: {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    })
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack(content: {
                        Text("\(highscore)")
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
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1: 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingSymbol)
                            .onAppear(perform: {
                                animatingSymbol.toggle()
                            })
                    }
                    
                    HStack(alignment: .center, spacing: 0, content: {
                        // MARK: - REEL 2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1: 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
                                .onAppear(perform: {
                                    animatingSymbol.toggle()
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL 3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1: 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingSymbol)
                                .onAppear(perform: {
                                    animatingSymbol.toggle()
                                })
                        }
                    })
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        // SET THE DEFAULT STATE: NO ANIMATION
                        animatingSymbol = false
                        
                        // SPIN THE REELS WITH CHANGING THE SYMBOLS
                        spinReels()
                        
                        // TRIGGER THE ANIMATION AFTER CHANGING THE SYMBOLS
                        withAnimation {
                            animatingSymbol = true
                        }
                        
                        // CHECK WINNING
                        checkWinning()
                        
                        // CHECK GAME IS OVER
                        isGameOver()
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
                
                HStack(content: {
                    // MARK: - BET 20
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            activateBet20()
                        }, label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundStyle(isActiveBet20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                        Image(.gfxCasinoChips)
                            .resizable()
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .animation(.easeOut, value: isActiveBet20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    Spacer()
                    
                    // MARK: - BET 10
                    HStack(alignment: .center, spacing: 10) {
                        Image(.gfxCasinoChips)
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .animation(.easeOut, value: isActiveBet10)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            activateBet10()
                        }, label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundStyle(isActiveBet10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                    }
                })
            }
            // MARK: - BUTTONS
            .overlay(alignment: .topLeading, content: {
                // RESET
                Button(action: {
                    resetGame()
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier())
            })
            .overlay(alignment: .topTrailing, content: {
                // INFO
                Button(action: {
                    showingInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier())
            })
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: showingModal ? 5 : 0, opaque: false)
            
            // MARK: - POPUP
            if showingModal {
                ZStack {
                    Color.colorTransparentBlack
                        .ignoresSafeArea()
                    
                    // MODAL
                    VStack(alignment: .center, spacing: 16, content: {
                        // TITLE
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded, weight: .heavy))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(.colorPink)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image(.gfxSevenReel)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 72)
                        
                        Text("Bad Luck! You lost all of the coins. \nLet´s play again!")
                            .font(.system(.body, design: .rounded))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.gray)
                            .layoutPriority(1)
                        
                        Button {
                            showingModal = false
                            animatingModal = false
                            activateBet10()
                            coins = 100
                        } label: {
                            Text("New Game".uppercased())
                                .font(.system(.body, design: .rounded, weight: .semibold))
                                .tint(.colorPink)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                .background {
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.75)
                                        .foregroundStyle(.colorPink)
                                }
                        }

                        
                        Spacer()
                    })
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .colorTransparentBlack, radius: 6, x: 0, y: 8)
                    .opacity(animatingModal ? 1 : 0)
                    .offset(y: animatingModal ? 0 : -100)
                    .animation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0), value: animatingModal)
                    .onAppear {
                        animatingModal = true
                    }
                }
            }
        }
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
        
    }
}

// MARK: - PREVIEW
#Preview {
    ContentView()
}
