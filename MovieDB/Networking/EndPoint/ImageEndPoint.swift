//
//  ImageEndPoint.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

public enum PosterImageApi {
    case posterImage(imagePath: String)
    case backposter(imagePath: String)
}

extension PosterImageApi: EndPointType {

    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://image.tmdb.org/t/p/w500/"
        case .qa: return "http://image.tmdb.org/t/p/w500/"
        case .staging: return "http://image.tmdb.org/t/p/w500/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .posterImage(let imagePath):
            return "\(imagePath)"
        case .backposter(let imagePath):
            return "\(imagePath)"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
