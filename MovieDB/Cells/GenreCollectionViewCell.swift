//
//  GenreCollectionViewCell.swift
//  MovieDB
//
//  Created by Balutkar, Chinmay (US - Mumbai) on 03/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    static let cellId = "GenreCollectionViewCell"

    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var genreTitleBorderView: UIView!

    /// Set up UI for cell
    func setupUI() {
        genreTitleBorderView.backgroundColor = .white
        genreTitleBorderView.layoutIfNeeded()
        genreTitleBorderView.layer.borderWidth = 1
        genreTitleBorderView.layer.borderColor = UIColor.darkGray.cgColor
        genreTitleBorderView.layer.shadowColor = UIColor.black.cgColor
        genreTitleBorderView.layer.shadowRadius = 1
        genreTitleBorderView.layer.shadowOffset = .zero
        genreTitleBorderView.layer.shadowOpacity = 0.5
        genreTitleBorderView.layer.cornerRadius = genreTitleBorderView.bounds.height/2
    }

}
