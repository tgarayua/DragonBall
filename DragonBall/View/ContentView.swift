//
//  ContentView.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    HStack {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 400)
                        
                        Text(character.name)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Dragon Ball Characters")
            .task {
                await viewModel.loadCharacters()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
