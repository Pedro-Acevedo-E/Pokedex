//
//  Pokemon.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation
import SwiftUI

protocol PokemonElement {
    var id: Int { get set }
    var name: String { get set }
    var types: [String] { get set }
    var artworkURL: URL? { get set }
}

struct ErrorPokemon: Identifiable, Equatable, PokemonElement {
    var id: Int
    var name: String
    var types: [String]
    var artworkURL: URL?
    var error: String
    
    init(id: Int, name: String, error: String) {
        self.id = id
        self.name = name
        self.error = error
        types = ["???"]
        artworkURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/error.png")
    }
}

struct Pokemon: Identifiable, Equatable, PokemonElement {
    var id: Int
    var name: String
    var types: [String]
    var artworkURL: URL?
    var height: Measurement<UnitLength>
    var weight: Measurement<UnitMass>
    var abilities: [PokemonAbilities]
    var baseStats: [PokemonStats]
    var moves: [PokemonMoves]
    var baseSpeciesName: String
    var species: String?
    var gender: Double?
    var eggGroup: [PokemonResult] = []
    var eggCycle: Int?
    var evolutionChain: EvolutionChain?
    
    mutating func setSpeciesInfo(info: Species) {
        self.species = getPokemonSpecies(genus: info.pokemonSpecies.genera)
        self.gender = (Double(info.pokemonSpecies.genderRate) / 8) * 100
        self.eggGroup = info.pokemonSpecies.eggGroups
        self.eggCycle = 255 * (info.pokemonSpecies.hatchCounter + 1)
        self.evolutionChain = info.evolutionChain
    }
     
    internal func getPokemonSpecies(genus: [PokemonGenus]) -> String {
        genus.first { $0.language.name == "en" }?.genus ?? "No Species"
    }
}
/*
extension Pokemon {
    static let demo = Self.init(name: "pikachu", from: PokemonDetails.demo)
    static let wooper = Self.init(name: "wooper", from: PokemonDetails.wooper)
    static let greninja = Self.init(name: "greninja", from: PokemonDetails.greninja)
    static let errorPokemon = Self.init(name: "missingno", from: PokemonDetails.demo)
}
 */

extension Pokemon {
    init(name: String ,from details: PokemonDetails) {
        self.init(
            id: details.id,
            name: name,
            types: details.types.map(\.type.name),
            artworkURL: URL(string: details.sprites.other.offArtwork.frontDefault),
            height: Measurement(value: Double(details.height), unit: UnitLength.decimeters),
            weight: Measurement(value: Double(details.weight * 100), unit: UnitMass.grams),
            abilities: details.abilities,
            baseStats: details.stats,
            moves: Self.getPokemonLevelUpMoves(moves: details.moves),
            baseSpeciesName: details.species.name
        )
    }
    
    init(name: String, id: Int) {
        self.init(
            id: id,
            name: name,
            types: ["???"],
            artworkURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/error.png"),
            height: Measurement(value: Double(0.0), unit: UnitLength.decimeters),
            weight: Measurement(value: Double(0.0), unit: UnitMass.grams),
            abilities: [PokemonAbilities(ability: PokemonResult(name: "", url: ""), isHidden: true, slot: 1)],
            baseStats: [PokemonStats(baseStat: 0, effort: 0, stat: PokemonResult(name: "", url: ""))],
            moves: [PokemonMoves(move: PokemonResult(name: "", url: ""), versionGroupDetails: [])],
            baseSpeciesName: ""
        )
    }
    
    static func getPokemonLevelUpMoves(moves: [PokemonMoves]) -> [PokemonMoves] {
        let levelUpMoves = moves.filter { move in
            move.versionGroupDetails.last?.moveLearnMethod.name == "level-up"
        }.sorted { first, second in
            guard let firstLast = first.versionGroupDetails.last, let secondLast = second.versionGroupDetails.last else {
                return false
            }
            return firstLast.levelLearnedAt < secondLast.levelLearnedAt
        }
        return levelUpMoves
    }
}

extension Pokemon {
    var backgroundColor: Color {
        switch(types[0]){
        case "grass":
            return Color("grass")
        case "fire":
            return Color("fire")
        case "water":
            return Color("water")
        case "bug":
            return Color("bug")
        case "electric":
            return Color("electric")
        case "rock":
            return Color("rock")
        case "ground":
            return Color("ground")
        case "dark":
            return Color("dark")
        case "fighting":
            return Color("fighting")
        case "steel":
            return Color("steel")
        case "normal":
            return Color("normal")
        case "ghost":
            return Color("ghost")
        case "poison":
            return Color("poison")
        case "dragon":
            return Color("dragon")
        case "flying":
            return Color("flying")
        case "psychic":
            return Color("psychic")
        case "fairy":
            return Color("fairy")
        case "ice":
            return Color("ice")
        default:
            return .white
        }
    }
}

enum SelectedTabs {
    case about
    case baseStats
    case evolution
    case moves
}
