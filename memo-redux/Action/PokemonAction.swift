//
//  PostAction.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/04/08.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import Foundation
import ReSwift

extension PokemonState {
    enum Action: ReSwift.Action {
        case updatePokemon(pokemon: Pokemon)
    }
}
