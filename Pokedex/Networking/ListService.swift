//
//  ListService.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

protocol ListableService {
    func getList(offset: Int, limit: Int) async -> Result<[PokemonElement], NetworkError>
}

class ListService: ListableService {
    func getList(offset: Int, limit: Int) async -> Result<[PokemonElement], NetworkError> {
        let urlString = API.getURLForPokemonList(offset: offset, limit: limit)
        let result = await NetworkManager<PokeAPIResponse>.fetch(for: URL(string: urlString)!)
        return await processPokeAPIResponse(result: result)
    }
    
    internal func processPokeAPIResponse(result: Result<PokeAPIResponse,NetworkError>) async -> Result<[PokemonElement],NetworkError> {
        switch result {
        case .success(let pokeApiResponse):
            let pokemonList = await processPokeAPIResponseResults(results: pokeApiResponse.results)
            return .success(pokemonList)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    internal func processPokeAPIResponseResults(results: [PokemonResult]) async -> [PokemonElement] {
        var pokemonList = [PokemonElement]()
        for responseResult in results {
            if let pathId = URL(string: responseResult.url)?.lastPathComponent,
               let unwrappedID = Int(pathId) {
                let id = unwrappedID
                let result = await DetailsService.getDetails(of: id)
                switch result {
                case .success(let details):
                    pokemonList.append(Pokemon(name: responseResult.name, from: details))
                case .failure(let err):
                    pokemonList.append(ErrorPokemon(id: id, name: responseResult.name, error: err.localizedDescription))
                }
            }
        }
        return pokemonList
    }
}
