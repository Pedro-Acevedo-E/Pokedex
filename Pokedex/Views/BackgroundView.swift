//
//  BackgroundView.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 11/04/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Image("background")
                    .resizable()
                    .frame(width: 240, height: 240)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
