//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let cellId = "MovieTableViewCell"

    @IBOutlet private weak var bookButton: UIButton!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var contaierView: UIView!
//    @IBOutlet private weak var moviePosterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contaierView.layer.masksToBounds = true
        contaierView.layer.cornerRadius = 10.0
        setGradientBackground()
    }

    func setUpView(with movie: Movie) {
        movieNameLabel.text = movie.title
        movieNameLabel.font = .getGothicBoldFont(size: 16.0)
        movieNameLabel.textColor = .white
        movieNameLabel.setLineSpacing(value: 4.0)

        releaseDateLabel.text = movie.releaseDate
        releaseDateLabel.font = .getGothicRegularFont(size: 14.0)
        releaseDateLabel.textColor = .white

        bookButton.backgroundColor = .buttonBackgroundColor()
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.layer.masksToBounds = true
        bookButton.layer.cornerRadius = 10.0
    }

    private func setGradientBackground() {
        let colorTop =  UIColor.gradientTopColor().cgColor
        let colorBottom = UIColor.gradientBottomColor().cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.contaierView.bounds

        contaierView.layer.insertSublayer(gradientLayer, at:0)
    }
}