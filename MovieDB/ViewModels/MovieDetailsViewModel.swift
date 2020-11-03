//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {

    private var networkManager = NetworkManager()
    private(set) var movie: Movie?
    var casts: [Cast]?
    let movieDetailsContent: [DetailsCellType] = [.detailsCell, .summaryCell, .castCell]
    var reloadViewWithLatestMoviesDetails: (() -> Void)?

    init(movie: Movie) {
        self.movie = movie
        getCastAndCrewDetails()
    }

    /// API call get Cast & Crew
    private func getCastAndCrewDetails() {
        guard let movieId = movie?.id else { return }
        networkManager.getCastAndCrew(movieId: movieId) {[weak self] (casts, error) in
            self?.casts = casts
            self?.reloadViewWithLatestMoviesDetails?()
        }
    }
}
