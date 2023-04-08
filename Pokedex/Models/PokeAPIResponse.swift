//
//  PokeAPIResponse.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

struct PokeAPIResponse: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PokemonResult]
}
