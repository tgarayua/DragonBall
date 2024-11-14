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
    @Published var searchQuery = ""
    private var service = CharacterService()
    private var page = 1  // Starting page
    var canLoadMore = true
    
    var filteredCharacters: [Character] {
        if searchQuery.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    func loadCharacters() async {
        guard canLoadMore else { return }
        
        do {
            let newCharacters = try await service.fetchCharacters(page: page)
            characters.append(contentsOf: newCharacters)
            canLoadMore = !newCharacters.isEmpty
            page += 1
        } catch {
            print("Error loading characters: \(error.localizedDescription)")
        }
    }
    
    func refreshCharacters() {
        characters.removeAll()
        page = 1
        canLoadMore = true
    }
}

