//
//  SearchFooter.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation
import UIKit

class SearchFooter: UIView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureView()
    }

    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }

    func setNotFiltering() {
        label.text = ""
        hideFooter()
    }

    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if (filteredItemCount == totalItemCount) {
            setNotFiltering()
        } else if (filteredItemCount == 0) {
            label.text = NSLocalizedString("Filter.NoResultFound", comment: "")
            showFooter()
        } else {
            label.text = String(format: NSLocalizedString("Filter.ShowResult", comment: ""), arguments: [filteredItemCount, totalItemCount])
            showFooter()
        }
    }

    func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }

    func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }

    func configureView() {
        backgroundColor = UIColor.gradientTopColor()
        alpha = 0.0

        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
    }
}
