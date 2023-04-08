//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

struct EvolutionChain: Codable, Equatable {
    var babyTriggerItem: PokemonResult?
    var chain: Chain
    var id: Int
}

struct Chain: Codable, Hashable {
    var evolutionDetails: [EvolutionDetails]
    var evolvesTo: [Chain]
    var isBaby: Bool
    var species: PokemonResult
    
    var imageURL: URL? {
        get {
            if !species.url.isEmpty {
                if let unwrappedLastPathComponent = URL(string: species.url)?.lastPathComponent {
                    return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(unwrappedLastPathComponent).png")
                }
            }
            return nil
        }
    }
}


struct EvolutionDetails: Codable, Hashable {
    var gender: Int?
    var heldItem: PokemonResult?
    var item: PokemonResult?
    var knownMove: PokemonResult?
    var knownMoveType: PokemonResult?
    var location: PokemonResult?
    var minAffection: Int?
    var minBeauty: Int?
    var minHappiness: Int?
    var minLevel: Int?
    var needsOverworldRain: Bool
    var partySpecies: PokemonResult?
    var partyType: PokemonResult?
    var relativePhysicalStats: Int?
    var timeOfDay: String
    var tradeSpecies: PokemonResult?
    var trigger: PokemonResult?
    var turnUpsideDown: Bool
}
