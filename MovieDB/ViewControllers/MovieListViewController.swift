//
//  ViewController.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet private weak var moviesListTableView: UITableView!
    private var viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        bindViewModel()
        setUpView()
        viewModel.getLatestMoviesList()
    }

    private func setUpView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.rowHeight = UITableView.automaticDimension
        moviesListTableView.estimatedRowHeight = 100.0
        registerCells()
    }

    private func registerCells() {
        moviesListTableView.register(UINib(nibName: MovieTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellId)
    }

    private func bindViewModel() {
        viewModel.reloadViewWithLatestMoviesList = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesListTableView.reloadData()
            }
        }
    }

    private func reloadView() {

    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMoviesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellId, for: indexPath) as? MovieTableViewCell, let movie = viewModel.getMovie(for: indexPath) else {
            return UITableViewCell()
        }

        cell.setUpView(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}

