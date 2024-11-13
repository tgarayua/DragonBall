//
//  Character.swift
//  DragonBall
//
//  Created by Thomas Garayua on 11/13/24.
//

import Foundation

struct CharacterResponse: Codable {
    var items: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
}
