//
//  MainPokedexView.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 11/04/23.
//

import SwiftUI

struct MainPokedexView: View {
    @StateObject var pokemonViewModel = PokemonViewModel()
    @State var isLoading = false
    
    let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                if isLoading {
                    ProgressView().progressViewStyle(.circular)
                } else {
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        ForEach(pokemonViewModel.pokemonList, id: \.id) { poke in
                            PokemonCellView(pokemonElement: poke)
                        }
                    }
                }
            }
            .task {
                isLoading = true
                await pokemonViewModel.loadList()
                isLoading = false
            }
            .padding()
        }
    }
}
