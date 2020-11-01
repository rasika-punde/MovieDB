//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

class MovieListViewModel {

    private var networkManager = NetworkManager()
    private var movies: [Movie]? {
        didSet {
            reloadViewWithLatestMoviesList?()
        }
    }

    init() {
        
    }

    var reloadViewWithLatestMoviesList: (() -> Void)?

    func getLatestMoviesList() {
        networkManager.getNewMovies(page: 1) { [weak self] (movies, error) in
            guard let strongSelf = self else { return }
            strongSelf.movies = movies
        }
    }

    func getMoviesCount() -> Int {
        return movies?.count ?? 0
    }

    func getMovie(for index: IndexPath) -> Movie? {
        return movies?[index.row]
    }
}
