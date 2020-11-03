//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

enum DetailsCellType: String {
    case detailsCell = "MovieDetailsTableViewCell"
    case summaryCell = "SummaryTableViewCell"
    case castCell = "CastAndCrewTableViewCell"
}

class MovieDetailsViewController: UIViewController {
    static let id = "MovieDetailsViewController"
    struct Constant {
        static let estimatedRowHeight = CGFloat(100.0)
    }

    @IBOutlet weak var movieDetailsTableView: UITableView!

    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        registerCells()
        setUpView()
    }

    private func setUpView() {
        movieDetailsTableView.delegate = self
        movieDetailsTableView.dataSource = self
        movieDetailsTableView.rowHeight = UITableView.automaticDimension
        movieDetailsTableView.estimatedRowHeight = Constant.estimatedRowHeight
    }

    private func registerCells() {
        self.movieDetailsTableView.register(UINib(nibName: DetailsCellType.detailsCell.rawValue, bundle: nil), forCellReuseIdentifier: DetailsCellType.detailsCell.rawValue)

         self.movieDetailsTableView.register(UINib(nibName: DetailsCellType.castCell.rawValue, bundle: nil), forCellReuseIdentifier: DetailsCellType.castCell.rawValue)

         self.movieDetailsTableView.register(UINib(nibName: DetailsCellType.summaryCell.rawValue, bundle: nil), forCellReuseIdentifier: DetailsCellType.summaryCell.rawValue)
    }

    private func bindViewModel() {
        viewModel.reloadViewWithLatestMoviesDetails = { [weak self] in
            DispatchQueue.main.async {
                self?.movieDetailsTableView.reloadData()
            }
        }
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieDetailsContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.movieDetailsContent[indexPath.row]
        switch cellType {
        case .detailsCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.cellId, for: indexPath) as? MovieDetailsTableViewCell, let movie = viewModel.movie else {
                return UITableViewCell()
            }
            cell.setUpView(movie: movie)
            return cell
        case .summaryCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.cellId, for: indexPath) as? SummaryTableViewCell, let movieSummary = viewModel.movie?.overview else {
                return UITableViewCell()
            }
            cell.setUpView(summaryText: movieSummary)
            return cell
        case .castCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastAndCrewTableViewCell.cellId, for: indexPath) as? CastAndCrewTableViewCell, let movieCasts = viewModel.casts else {
                return UITableViewCell()
            }
            cell.cast = movieCasts
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
