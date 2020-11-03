//
//  Model.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

struct MovieApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieApiResponse: Decodable {

    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)

        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)

    }
}

enum Genres: Int, Decodable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentry = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37

    var title: String {
        get {
            switch self {
            case .action:
                return "Action"
            case .adventure:
                return "Adventure"
            case .animation:
                return "Animation"
            case .comedy:
                return "Comedy"
            case .crime:
                return "Crime"
            case .documentry:
                return "Documentary"
            case .drama:
                return "Drama"
            case .family:
                return "Family"
            case .fantasy:
                return "Fantasy"
            case .history:
                return "History"
            case .horror:
                return "Horror"
            case .music:
                return "Music"
            case .mystery:
                return "Mystery"
            case .romance:
                return "Romance"
            case .scienceFiction:
                return "Science Fiction"
            case .tvMovie:
                return "TV Movie"
            case .thriller:
                return "Thriller"
            case .war:
                return "War"
            case .western:
                return "Western"
            }
        }
    }
}

struct Movie {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    let genres: [Genres]
    let isAdultMovie: Bool
}

extension Movie: Decodable {

    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case genres = "genre_ids"
        case adult = "adult"
        case overview
    }

    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)

        id = try movieContainer.decode(Int.self, forKey: .id)
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
        backdrop = try movieContainer.decode(String.self, forKey: .backdrop)
        title = try movieContainer.decode(String.self, forKey: .title)
        releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
        rating = try movieContainer.decode(Double.self, forKey: .rating)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        genres = try movieContainer.decode([Genres].self, forKey: .genres)
        isAdultMovie = try movieContainer.decode(Bool.self, forKey: .adult)
    }
}
