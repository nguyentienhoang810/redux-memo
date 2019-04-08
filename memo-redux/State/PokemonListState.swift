//
//  PostListState.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/04/08.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import Foundation
import ReSwift

struct PokemonList: Codable {
    var pokemons: [Pokemon]?
}


struct PokemonListState: StateType {
    var pokemons = [Pokemon]()
    var pokemonState = PokemonState()
}
