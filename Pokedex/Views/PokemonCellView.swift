//
//  PokemonCellView.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 11/04/23.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemonElement : PokemonElement

    var body: some View {
        if let pokemon = pokemonElement as? Pokemon {
            ZStack{
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .fill(pokemon.backgroundColor)
                    
                    Image("PokeballCell")
                        .resizable()
                        .frame(width: 140.4, height: 121.5, alignment: .bottomTrailing)
                }
                .clipShape(RoundedRectangle(cornerRadius: 40))
                VStack(alignment: .leading, spacing: 8){
                    Text(pokemon.name.capFirstLetter())
                        .bold()
                        .foregroundColor(.black)
                        .opacity(0.45)
                        .font(.custom("Arial", size: 22, relativeTo: .largeTitle))
                        .lineLimit(1)
                    HStack{
                        ForEach(pokemon.types, id: \.self) { type in
                            TypesView(type: type)
                        }
                    }
                    //favorites toggle
                    Image(systemName: "heart.fill")
                        .opacity(0.35)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                }
                .frame(width: 150, height: 150, alignment: .topLeading)
                
                ZStack {
                    if let imageURL = pokemon.artworkURL?.absoluteString {
                        AsyncImage(url: URL(string: imageURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 90, height: 90)
                            case .success(let image):
                                image.resizable()
                                    .frame(width: 90, height: 90)
                            case .failure:
                                Image("missingno")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .padding(5)
                            @unknown default:
                                Image(systemName: "questionmark")
                            }
                        }
                    } else {
                        Image("missingno")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                }
                .frame(width: 170, height: 170, alignment: .bottomTrailing)
            }
            .frame(width: 175, height: 175 )
        }
        if let pokemon = pokemonElement as? ErrorPokemon {
            ErrorCellView(errorPokemon: pokemon)
        }
    }
}
