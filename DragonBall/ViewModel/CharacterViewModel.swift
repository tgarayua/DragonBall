//
//  CharacterViewModel.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private var service = CharacterService()
    
    func loadCharacters() async {
        do {
            characters = try await service.fetchCharacters()
        } catch {
            print("Error loading characters: \(error.localizedDescription)")
        }
    }
}
