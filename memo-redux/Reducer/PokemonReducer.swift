//
//  PostStateReducer.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/04/08.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import Foundation
import ReSwift

extension PokemonState {
    static func reducer(action: ReSwift.Action, state: PokemonState?) -> PokemonState{
        var state = state ?? PokemonState()
        if let action = action as? Action {
            switch action {
            case let .updatePokemon(pokemon):
                state.pokemon = pokemon
            }
        }
        return state
    }
}
