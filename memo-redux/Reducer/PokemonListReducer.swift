//
//  PostListReducer.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/04/08.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import Foundation
import ReSwift

extension PokemonListState {
    static func reducer(action: ReSwift.Action, state: PokemonListState?) -> PokemonListState {
        var state = state ?? PokemonListState()

        if let action = action as? Action {
            switch action {
            case let .updatePokemons(pokemons):
                state.pokemons = pokemons
            }
        }

        state.pokemonState = PokemonState.reducer(action: action, state: state.pokemonState)

        return state
    }
}
