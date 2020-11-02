//
//  ViewController.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    struct Constant {
        static let estimatedRowHeight = CGFloat(100.0)
        static let keyboardDefaultSpacing = CGFloat(25.0)
    }

    @IBOutlet private weak var moviesListTableView: UITableView!
    @IBOutlet private weak var searchFooter: SearchFooter!
    @IBOutlet private weak var searchFooterBottomConstraint: NSLayoutConstraint!
    
    private var viewModel = MovieListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)

    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        observeotification()
        setUpView()
        viewModel.getLatestMoviesList()
    }

    private func observeotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
    }

    private func setUpView() {
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.rowHeight = UITableView.automaticDimension
        moviesListTableView.estimatedRowHeight = Constant.estimatedRowHeight

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("SearchBar.Placeholder", comment: "")
        navigationItem.searchController = searchController
        definesPresentationContext = true

        registerCells()
    }

    private func registerCells() {
        moviesListTableView.register(UINib(nibName: MovieTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellId)
    }

    private func bindViewModel() {
        viewModel.reloadViewWithLatestMoviesList = { [weak self] in
            self?.reloadView()
        }
    }

    private func reloadView() {
        DispatchQueue.main.async {
            self.moviesListTableView.reloadData()
        }
    }

    private func handleKeyboard(notification: Notification) {
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            searchFooterBottomConstraint.constant = 0
            view.layoutIfNeeded()
            return
        }

        guard let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
                return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.searchFooterBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        })


        if notification.name == UIResponder.keyboardWillHideNotification {
            moviesListTableView.contentInset = UIEdgeInsets.zero
        } else {
            moviesListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + Constant.keyboardDefaultSpacing, right: 0)
        }

        moviesListTableView.scrollIndicatorInsets = moviesListTableView.contentInset
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let moviesCount = viewModel.getMoviesCount(isFiltering: isFiltering)

        if isFiltering {
            searchFooter.setIsFilteringToShow(filteredItemCount:
                moviesCount, of: viewModel.movies?.count ?? 0)
            return moviesCount
        }

        searchFooter.setNotFiltering()
        return moviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellId, for: indexPath) as? MovieTableViewCell, let movie = viewModel.getMovie(for: indexPath, isFiltering: isFiltering) else {
            return UITableViewCell()
        }

        cell.setUpView(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MovieDetailsViewController.id) as? MovieDetailsViewController else { return }
        let movie = viewModel.getMovie(for: indexPath, isFiltering: isFiltering)
        detailController.movie = movie
        navigationController?.pushViewController(detailController, animated: true)
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.filterContentForSearchText(searchBar.text!)
    }
}

