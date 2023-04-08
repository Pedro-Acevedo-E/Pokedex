//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

struct PokemonSpecies: Codable {
    var eggGroups: [PokemonResult]
    var evolutionChain: EvoChainURL
    var flavorTextEntries: [FlavorText]
    var genderRate: Int
    var genera: [PokemonGenus]
    var hatchCounter: Int
    var name: String
}

struct PokemonGenus: Codable {
    var genus: String
    var language: PokemonResult
}

struct EvoChainURL: Codable {
    var url: String
}

struct FlavorText: Codable {
    var flavorText: String
    var language: PokemonResult
    var version: PokemonResult
}

struct Species {
    let pokemonSpecies: PokemonSpecies
    var evolutionChain: EvolutionChain? = nil
}
