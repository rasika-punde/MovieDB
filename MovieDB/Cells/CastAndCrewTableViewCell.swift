//
//  CastAndCrewTableViewCell.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class CastAndCrewTableViewCell: UITableViewCell {
    struct Constant {
        static let minimumSpacing = CGFloat(10)
        static let itemSizeWidth = CGFloat(100)
        static let itemSizeHeight = CGFloat(100)
    }
    static let cellId = "CastAndCrewTableViewCell"

    @IBOutlet private weak var castAndCrewLabel: UILabel!
    @IBOutlet private weak var castCollectionView: UICollectionView!

    var cast: [Cast]? {
        didSet {
            DispatchQueue.main.async {
                self.castCollectionView.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
        setUpView()
    }

    private func setUpView() {
        castAndCrewLabel.text = NSLocalizedString("CastAndCrew.Title", comment: "")
        castAndCrewLabel.font = .getGothicBoldFont(size: 20.0)
        castAndCrewLabel.textColor = .black
        castCollectionView.isScrollEnabled = true
        castCollectionView.bounces = false
        castCollectionView.delegate = self
        castCollectionView.dataSource = self

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Constant.minimumSpacing
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.itemSize = CGSize(width: Constant.itemSizeWidth, height: Constant.itemSizeHeight)
        flowLayout.scrollDirection = .horizontal
        castCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }

    private func registerCells() {
        let castCollectionViewCell = UINib(nibName: CastCollectionViewCell.cellId, bundle: nil)
        self.castCollectionView.register(castCollectionViewCell, forCellWithReuseIdentifier: CastCollectionViewCell.cellId)
    }
}

extension CastAndCrewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.cellId, for: indexPath) as? CastCollectionViewCell, let cast = self.cast?[indexPath.row] else {
            return UICollectionViewCell()
        }

        cell.setUpView(cast: cast)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.itemSizeWidth, height: Constant.itemSizeHeight)
    }
}
