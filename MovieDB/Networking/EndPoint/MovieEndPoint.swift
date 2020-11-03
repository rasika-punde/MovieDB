//
//  MovieEndPoint.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case guestSession
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case castAndCrew(id: Int)
    case movieDetails(id: Int)
    case movieReviews(id: Int)
    case similarMovies(id: Int)
}

extension MovieApi: EndPointType {

    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .movieDetails(let id):
            return "movie/\(id)"
        case .movieReviews(let id):
            return "\(id)/reviews"
        case .similarMovies(let id):
            return "\(id)/similar"
        case .castAndCrew(let id):
            return "\(id)/credits"
        case .guestSession:
            return "authentication/guest_session/new"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        case .castAndCrew:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        case .movieDetails:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        case .similarMovies:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        case .movieReviews:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        case .guestSession:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}


