//
//  ContentView.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pokemonViewModel = PokemonViewModel()
    @State var isLoading = false
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView().progressViewStyle(.circular)
            } else {
                ForEach(pokemonViewModel.pokemonList, id: \.id) { poke in
                    Text(poke.name)
                    if let pokemon = poke as? Pokemon, let imageURL = pokemon.artworkURL?.absoluteString {
                        AsyncImage(url: URL(string: imageURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            case .success(let image):
                                image.resizable()
                                    .frame(width: 80, height: 80)
                            case .failure:
                                Image("missingno")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            @unknown default:
                                Image(systemName: "questionmark")
                            }
                        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
