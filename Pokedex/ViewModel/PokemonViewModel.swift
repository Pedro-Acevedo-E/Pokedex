//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonElement] = []
    internal var service: ListableService
    internal var errorOcurred: Bool = false
    
    init(service: ListableService = ListService()) {
        self.service = service
    }
    
    private let limit = 20
    private var offset = 0
    
    @Sendable
    func loadList() async {
        let result = await service.getList(offset: offset, limit: limit)
        switch result {
        case .success(let list):
            pokemonList.append(contentsOf: list)
        case .failure(let err):
            errorOcurred = true
            print(err.localizedDescription)
        }
    }
    
    @Sendable
    func loadMore(pokemon: PokemonElement) async {
        if let last = pokemonList.last {
            if pokemon.id == last.id {
                self.offset += self.limit
                await loadList()
            }
        }
    }
}
