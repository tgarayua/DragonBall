//
//  ContentView.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharacterViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 20)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    // Animated Search Bar
                    TextField("Search characters", text: $viewModel.searchQuery)
                        .padding(10)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.9), radius: 8, x: 0, y: 4)
                        .scaleEffect(viewModel.searchQuery.isEmpty ? 1.0 : 1.05)
                        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.searchQuery)

                    // Character Grid with animated scaling
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.filteredCharacters) { character in
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    VStack {
                                        AsyncImage(url: URL(string: character.image)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .scaledToFill()
                                        .frame(width: 100, height: 300)
                                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                                        .scaleEffect(1.05)
                                        .animation(.easeOut(duration: 0.3), value: character.id)

                                        Text(character.name)
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                                    .scaleEffect(1.0)
                                    .animation(.easeInOut(duration: 0.3), value: character.id)
                                }
                            }
                        }
                        .padding()

                        // Load More Button with animation
                        if viewModel.canLoadMore {
                            Button(action: {
                                Task {
                                    await viewModel.loadCharacters()
                                }
                            }) {
                                Text("Load More")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(
                                        gradient: Gradient(colors: [.purple, .blue]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                                    .scaleEffect(1.05)
                                    .animation(.spring(response: 0.6, dampingFraction: 0.7))
                            }
                            .padding()
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .task {
                await viewModel.loadCharacters()
            }
            .toolbar {
                // Apply a gradient to the title
                ToolbarItem(placement: .principal) {
                    Text("Dragon Ball Characters")
                        .font(.largeTitle.bold())
                        .foregroundStyle(LinearGradient(
                            gradient: Gradient(colors: [.orange, .red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                }
            }
            .onChange(of: viewModel.searchQuery) { _ in
                viewModel.refreshCharacters()
                Task {
                    await viewModel.loadCharacters()
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
