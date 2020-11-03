//
//  CastAndCrew.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

struct CastAndCrew {
    let id: Int
    let castList: [Cast]?
}

extension CastAndCrew: Decodable {

    enum CastAndCrewCodingKeys: String, CodingKey {
        case id
        case cast
    }

    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: CastAndCrewCodingKeys.self)
        id = try movieContainer.decode(Int.self, forKey: .id)
        castList = try movieContainer.decodeIfPresent([Cast].self, forKey: .cast)
    }
}
