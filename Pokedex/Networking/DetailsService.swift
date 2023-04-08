//
//  DetailsService.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

protocol DetailService {
    func getSpecies(of name: String) async -> Result<Species, NetworkError>
    func getEvolutionDetails(for url: String) async -> Result<EvolutionChain, NetworkError>
}

class DetailsService: DetailService {
    static func getDetails(of id: Int) async -> Result<PokemonDetails, NetworkError> {
        let urlString = API.getURLForPokemonDetails(id: id)
        return await NetworkManager<PokemonDetails>.fetch(for: URL(string: urlString)!)
    }
    
    func getSpecies(of name: String) async -> Result<Species, NetworkError> {
        let urlString = API.getURLForPokemonSpecies(name: name)
        let result = await NetworkManager<PokemonSpecies>.fetch(for: URL(string: urlString)!)
        return await processEvolutionDetails(for: result)
    }
    
    internal func processEvolutionDetails(for result: Result<PokemonSpecies, NetworkError>) async -> Result<Species, NetworkError> {
        switch result {
        case .success(let speciesInfo):
            let evolutionResult = await self.getEvolutionDetails(for: speciesInfo.evolutionChain.url)
            if case let .success(chainInfo) = evolutionResult {
                return .success(Species(pokemonSpecies: speciesInfo, evolutionChain: chainInfo))
            }
            return .success(Species(pokemonSpecies: speciesInfo))
        case .failure(let err):
            return .failure(err)
        }
    }
    
    func getEvolutionDetails(for url: String) async -> Result<EvolutionChain, NetworkError> {
        if let unwrappedURL = URL(string: url) {
            return await NetworkManager<EvolutionChain>.fetch(for: unwrappedURL)
        }
        return .failure(.error(err: "getEvolutionDetails: invalid URL"))
    }
}

