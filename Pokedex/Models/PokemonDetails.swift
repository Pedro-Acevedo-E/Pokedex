//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

struct PokemonDetails: Codable {
    var abilities: [PokemonAbilities]
    var forms: [PokemonResult]
    var height: Int
    var id: Int
    var moves: [PokemonMoves]
    var name: String
    var species: PokemonResult
    var sprites: PokemonSprites
    var stats: [PokemonStats]
    var types: [PokemonTypes]
    var weight: Int
}

struct PokemonAbilities: Codable, Hashable, Equatable{
    var ability: PokemonResult
    var isHidden: Bool
    var slot: Int
}

struct PokemonMoves: Codable, Hashable , Equatable{
    var move: PokemonResult
    var versionGroupDetails: [PokemonMovesVersionDetails]
}

struct PokemonMovesVersionDetails: Codable, Hashable, Equatable {
    var levelLearnedAt: Int
    var moveLearnMethod: PokemonResult
    var versionGroup: PokemonResult
}

struct PokemonTypes: Codable {
    var slot: Int
    var type: PokemonResult
}

struct PokemonSprites: Codable {
    var frontDefault: String
    var other: PokemonOtherSprite
}

struct PokemonOtherSprite: Codable {
    var offArtwork: Artwork
    
    enum CodingKeys: String, CodingKey {
        case offArtwork = "official-artwork"
    }
}

struct Artwork: Codable {
    var frontDefault: String
}

struct PokemonStats: Codable, Hashable, Equatable{
    var baseStat: Int
    var effort: Int
    var stat: PokemonResult
}
