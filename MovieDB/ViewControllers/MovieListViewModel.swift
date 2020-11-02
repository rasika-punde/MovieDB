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
    private(set) var movies: [Movie]? {
        didSet {
            reloadViewWithLatestMoviesList?()
        }
    }

    var filteredMovies: [Movie] = []
    var reloadViewWithLatestMoviesList: (() -> Void)?

    func getLatestMoviesList() {
        networkManager.getNewMovies(page: 1) { [weak self] (movies, error) in
            guard let strongSelf = self else { return }
            strongSelf.movies = movies
        }
    }

    func getMoviesCount(isFiltering: Bool) -> Int {
        return isFiltering ? filteredMovies.count : movies?.count ?? 0
    }

    func getMovie(for index: IndexPath, isFiltering: Bool) -> Movie? {
        if isFiltering {
            return filteredMovies[index.row]
        }
        return movies?[index.row]
    }

    func filterContentForSearchText(_ searchText: String) {

        let filteredMoviesContainsText = movies?.filter { (movie: Movie) -> Bool in
            movie.title.lowercased().contains(searchText.lowercased())
        }

        let filteredMovies = movies?.filter { (movie: Movie) -> Bool in
            let title = movie.title.lowercased()
            let arrayOfWordsInTitle = title.wordList
            let result = arrayOfWordsInTitle.filter {
                $0.hasPrefix(searchText.lowercased())
            }
            return result.count > 0
        }

        var moviesList: [Movie]
        if let filteredMoviesList = filteredMovies, filteredMoviesList.count > 0 {
            moviesList = filteredMoviesList
        } else {
            guard let movies = filteredMoviesContainsText else { return }
            moviesList = movies
        }

        self.filteredMovies = moviesList
        reloadViewWithLatestMoviesList?()
    }
}

