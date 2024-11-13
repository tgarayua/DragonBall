//
//  CharacterDetailView.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                
                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Race: \(character.race)")
                Text("Gender: \(character.gender)")
                Text("Ki: \(character.ki)")
                Text("Max Ki: \(character.maxKi)")
                Text("Affiliation: \(character.affiliation)")
                Text("Description: \(character.description)")
                    .padding()
            }
            .padding()
        }
        .navigationTitle(character.name)
    }
}


//#Preview {
//    CharacterDetailView()
//}
