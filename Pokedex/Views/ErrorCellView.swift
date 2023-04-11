//
//  ErrorCellView.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 11/04/23.
//

import SwiftUI

struct ErrorCellView: View {
    let errorPokemon: ErrorPokemon
    
    var body: some View {
        ZStack{
            ZStack(alignment: .bottomTrailing) {
                Rectangle()
                    .fill(.white)
                
                Image("PokeballCell")
                    .resizable()
                    .frame(width: 140.4, height: 121.5, alignment: .bottomTrailing)
            }
            .overlay (
                RoundedRectangle(cornerRadius: 40)
                    .stroke(.black, lineWidth: 1)
            )
            
            
            VStack(alignment: .leading, spacing: 8){
                Text(errorPokemon.name.capFirstLetter())
                    .bold()
                    .foregroundColor(.black)
                    .opacity(0.45)
                    .font(.custom("Arial", size: 22, relativeTo: .largeTitle))
                    .lineLimit(1)
                HStack{
                    ForEach(errorPokemon.types, id: \.self) { type in
                        TypesView(type: type)
                    }
                }
            }
            .frame(width: 150, height: 150, alignment: .topLeading)
            
            ZStack {
                Image("missingno")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(5)
            }
            .frame(width: 170, height: 170, alignment: .bottomTrailing)
        }
        .frame(width: 175, height: 175 )
    }
}

