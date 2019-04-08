//
//  PostListAction.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/04/08.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import Foundation
import ReSwift

extension PokemonListState {
    enum Action: ReSwift.Action {
        case updatePokemons(pokemons: [Pokemon])
    }
}
