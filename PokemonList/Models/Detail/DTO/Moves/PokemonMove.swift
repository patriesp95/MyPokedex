//
//  PokemonMove.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct PokemonMove: Decodable {
    var move: Move
    var version_group_details: [VersionGroupDetail]
}

struct Move: Decodable {
    var name: String
    var url: String
}

struct VersionGroupDetail: Decodable {
    var level_learned_at: Int
    var move_learn_method: MoveLearnMethod
    var version_group: VersionGroup
}


struct MoveLearnMethod: Decodable {
    var name: String
    var url: String
}
struct VersionGroup: Decodable {
    var name: String
    var url: String
}
