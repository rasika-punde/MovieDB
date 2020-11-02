//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    static let id = "MovieDetailsViewController"

    @IBOutlet weak var movieTitleLabel: UILabel!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        self.movieTitleLabel.text = movie?.title
    }
}
