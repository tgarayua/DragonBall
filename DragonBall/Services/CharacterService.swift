//
//  CharacterService.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import Foundation

class CharacterService {
    private var baseUrl = "https://dragonball-api.com/api/characters"
    
    func fetchCharacters(page: Int) async throws -> [Character] {
        guard let url = URL(string: "\(baseUrl)?page=\(page)") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return characterResponse.items
    }
}

