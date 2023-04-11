//
//  TypesView.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 11/04/23.
//

import SwiftUI

struct TypesView: View {
    let type: String
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.gray)
                .frame(width: 78, height: 27, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.leading, -3)
            Text(type.capFirstLetter())
                .fontWeight(.semibold)
                .font(.custom("Arial", size: 16, relativeTo: .callout))
                .foregroundColor(.white)
                .frame(width: 74, height: 25, alignment: .center)
                .lineLimit(1)
        }
    }
}

extension String {
    func capFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capFirstLetter() {
        self = self.capFirstLetter()
    }
}
