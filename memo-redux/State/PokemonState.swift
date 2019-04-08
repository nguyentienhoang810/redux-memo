//
//  PostState.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/04/08.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import Foundation
import ReSwift

struct Pokemon: Codable {
    var name: String?
    var url: String?
}

struct PokemonState: StateType {
    var pokemon = Pokemon()
}
