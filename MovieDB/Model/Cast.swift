//
//  MovieDetails.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

struct Cast {
    let id: Int
    let name: String?
    let profilePath: String?
}

extension Cast: Decodable {

    enum CastCodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }


    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: CastCodingKeys.self)
        id = try movieContainer.decode(Int.self, forKey: .id)
        name = try movieContainer.decode(String.self, forKey: .name)
        profilePath = try movieContainer.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
