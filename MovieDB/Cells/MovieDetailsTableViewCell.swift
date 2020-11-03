//
//  MovieDetailsTableViewCell.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsTableViewCell: UITableViewCell {
    static let cellId = "MovieDetailsTableViewCell"

    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var adultMovieLabel: UILabel!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var scoreView: UIView!
    @IBOutlet private weak var addFavouriteMovie: UIButton!
    @IBOutlet private weak var genreCollectionView: UICollectionView!

    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var rateNowLabel: UILabel!
    
    var movie: Movie?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scoreView.layer.shadowOpacity = 1
        scoreView.layer.shadowColor = UIColor.black.cgColor
        scoreView.layer.shadowRadius = scoreView.frame.height/2
        scoreView.layer.cornerRadius = scoreView.frame.height/2
    }
    
    func setUpView(movie: Movie) {
        genreCollectionView.backgroundColor = .clear
        self.genreCollectionView.register(UINib(nibName: GenreCollectionViewCell.cellId, bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.cellId)
        genreCollectionView.showsHorizontalScrollIndicator = false
        self.movie = movie
        movieTitle.text = movie.title
        adultMovieLabel.text = movie.isAdultMovie ? "Adult" : "PG-13"
        adultMovieLabel.textColor = .darkGray
        movieTitle.font = .getGothicBoldFont(size: 20.0)
        movieTitle.textColor = .black
        releaseDateLabel.text = movie.releaseDate.getYear()
        releaseDateLabel.font = .getGothicBoldFont(size: 16.0)
        releaseDateLabel.textColor = .black

        let attrString = NSMutableAttributedString(string: "\(movie.rating)",
                                                   attributes: [NSAttributedString.Key.font: UIFont.getGothicSemiBoldFont(size: 20.0)]);

        attrString.append(NSMutableAttributedString(string: "/5",
                                                    attributes: [NSAttributedString.Key.font: UIFont.getGothicSemiBoldFont(size: 14.0)]));
        ratingLabel.attributedText = attrString
        ratingLabel.textColor = .buttonBackgroundColor()

        rateNowLabel.text = NSLocalizedString("RateNow.Title", comment: "")
        rateNowLabel.textColor = .buttonBackgroundColor()
        rateNowLabel.font = .getGothicBoldFont(size: 14.0)

        genreCollectionView.reloadData()
        let imageUrl = NetworkManager.baseImagePath + movie.posterPath
        posterImageView.downloadImage(urlString: imageUrl) { [weak self] (image, error) in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.resetImageView()
                if let image = image {
                    strongSelf.posterImageView.image = image
                    strongSelf.posterImageView.contentMode = .scaleAspectFill
                    strongSelf.posterImageView.layer.masksToBounds = true
                    strongSelf.posterImageView.layer.cornerRadius = 10.0
                } else {
                    strongSelf.resetImageView()
                }
            }
        }
        
        addFavouriteMovie.setTitle("", for: .normal)
        addFavouriteMovie.setBackgroundImage(UIImage(named: "plusImage"), for: .normal)
    }

    private func resetImageView() {
        self.posterImageView.image = nil
        //Show Placeholder Image
    }
    
}

extension MovieDetailsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.genres.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.cellId, for: indexPath) as? GenreCollectionViewCell, let movie = movie else {
            return UICollectionViewCell()
        }
        cell.genreTitleLabel.text = movie.genres[indexPath.row].title
        cell.setupUI()
        return cell
    }
}


extension MovieDetailsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 40)
    }
}
