//
//  API.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

struct API {
    static let baseURLString = "https://pokeapi.co/api/v2/"
    
    static func getURLForPokemonSpeciesList(offset: Int, limit: Int) -> String {
        return "\(baseURLString)pokemon-species?offset=\(offset))&limit=\(limit)"
    }
    
    static func getURLForPokemonList(offset: Int, limit: Int) -> String {
        return "\(baseURLString)pokemon?offset=\(offset))&limit=\(limit)"
    }
    
    static func getURLForPokemonDetails(id: Int) -> String {
        return "\(baseURLString)pokemon/\(id)/"
    }
    
    static func getURLForPokemonSpecies(name: String) -> String {
        return "\(baseURLString)pokemon-species/\(name)/"
    }
}
