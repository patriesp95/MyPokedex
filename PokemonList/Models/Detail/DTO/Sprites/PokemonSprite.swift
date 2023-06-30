//
//  PokemonSprite.swift
//  PokemonList
//
//  Created by patricia.martinez on 29/6/23.
//

import Foundation

struct PokemonSprite: Decodable {
    var back_default: URL
    var back_female: URL?
    var back_shiny: URL
    var back_shiny_female: URL?
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
    var other: Other
    var versions: Versions
}

struct Other {
    var dreamWorld: DreamWorld
    var home: Home
    var officialArtwork: OfficialArtwork
}

struct Versions {
    var generationI: GenerationI
    var generationII: GenerationII
    var generationIII: GenerationIII
    var generationIV: GenerationIV
    var generationV: GenerationV
    var generationVI: GenerationVI
    var generationVII: GenerationVII
    var generationVIII: GenerationVIII
    
}

struct DreamWorld: Decodable{
    var front_default: URL
    var front_female: URL?
}

struct Home: Decodable {
    var front_default: URL
    var front_female: URL?
    var front_shiny: URL
    var front_shiny_female: URL?
}

struct OfficialArtwork: Decodable {
    var front_default: URL
    var front_shiny: URL
}

extension Versions: Decodable {
    enum GenerationCodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationII = "generation-ii"
        case generationIII = "generation-iii"
        case generationIV = "generation-iv"
        case generationV = "generation-v"
        case generationVI = "generation-vi"
        case generationVII = "generation-vii"
        case generationVIII = "generation-viii"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenerationCodingKeys.self)
        generationI = try values.decode(GenerationI.self, forKey: .generationI)
        generationII = try values.decode(GenerationII.self, forKey: .generationII)
        generationIII = try values.decode(GenerationIII.self, forKey: .generationIII)
        generationIV = try values.decode(GenerationIV.self, forKey: .generationIV)
        generationV = try values.decode(GenerationV.self, forKey: .generationV)
        generationVI = try values.decode(GenerationVI.self, forKey: .generationVI)
        generationVII = try values.decode(GenerationVII.self, forKey: .generationVII)
        generationVIII = try values.decode(GenerationVIII.self, forKey: .generationVIII)

    }
}

extension Other: Decodable {
    enum OtherWorldCodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: OtherWorldCodingKeys.self)
        dreamWorld = try values.decode(DreamWorld.self, forKey: .dreamWorld)
        home = try values.decode(Home.self, forKey: .home)
        officialArtwork = try values.decode(OfficialArtwork.self, forKey: .officialArtwork)
    }
}
