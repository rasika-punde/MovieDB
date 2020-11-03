//
//  CastCollectionViewCell.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    static let cellId = "CastCollectionViewCell"

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var castProfileImageView: UIImageView!

    func setUpView(cast: Cast) {

        nameLabel.text = cast.name
        nameLabel.font = .getGothicBoldFont(size: 14.0)
        nameLabel.textColor = .black
        nameLabel.setLineSpacing(value: 4.0)

        guard let path = cast.profilePath else { return }
        let imageUrl = NetworkManager.baseImagePath + path

        castProfileImageView.downloadImage(urlString: imageUrl) { [weak self] (image, error) in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.resetImageView()
                if let image = image {
                    strongSelf.castProfileImageView.image = image
                    strongSelf.castProfileImageView.contentMode = .scaleAspectFill
                    strongSelf.castProfileImageView.layer.masksToBounds = true
                    strongSelf.castProfileImageView.layer.cornerRadius = strongSelf.castProfileImageView.bounds.height / 2.0
                } else {
                    strongSelf.resetImageView()
                }
            }
        }
    }

    private func resetImageView() {
        self.castProfileImageView.image = nil
        //Show Placeholder
    }
}
